#lang racket

(require racket/match)
(require racket/hash)
(require racket/string)
(require racket/vector)

(struct cell (content value dependents dependencies) #:mutable #t)

(define spreadsheet-cells (make-vector 27 (make-vector 27 #f)))

(define (get-cell r c)
  (vector-ref (vector-ref spreadsheet-cells r) c))

(define (cell-ref->coords s)
  (define col-char (string-ref s 0))
  (define col-idx (- (char->integer col-char) (char->integer #\A) -1))
  (define row-str (substring s 1))
  (define row-idx (string->number row-str))
  (cons row-idx col-idx))

(define (parse-formula formula-str)
  (define (cell-ref-or-num s)
    (cond
      [(string-match #rx"^[A-Z][0-9]+$" s)
       (cell-ref->coords s)]
      [(string-match #rx"^-?[0-9]+$" s)
       (string->number s)]
      [else (error "Invalid formula term: " s)]))

  (define formula-body (substring formula-str 1))
  (define parts (regexp-split #rx"([+\\-])" formula-body))

  (define terms '())
  (define current-op '+)

  (for ([part parts])
    (define trimmed-part (string-trim part))
    (unless (string=? trimmed-part "")
      (cond
        [(or (string=? trimmed-part "+") (string=? trimmed-part "-"))
         (set! current-op (string->symbol trimmed-part))]
        [else
         (set! terms (cons (cons current-op (cell-ref-or-num trimmed-part)) terms))
         (set! current-op '+)])))

  (reverse terms))

(define (clear-old-dependencies r c)
  (define current-cell (get-cell r c))
  (for ([dep-coord (cell-dependencies current-cell)])
    (define ref-r (car dep-coord))
    (define ref-c (cdr dep-coord))
    (define ref-cell (get-cell ref-r ref-c))
    (cell-dependents-set! ref-cell (remove (cons r c) (cell-dependents ref-cell) equal?)))
  (cell-dependencies-set! current-cell '()))

(define (establish-new-dependencies r c formula-str)
  (define current-cell (get-cell r c))
  (define new-deps '())
  (define terms (parse-formula formula-str))
  (for ([term terms])
    (match term
      [`(+ . ,cell-coord)
       (when (pair? cell-coord)
         (define ref-r (car cell-coord))
         (define ref-c (cdr cell-coord))
         (set! new-deps (cons (cons ref-r ref-c) new-deps))
         (define ref-cell (get-cell ref-r ref-c))
         (unless (member (cons r c) (cell-dependents ref-cell) equal?)
           (cell-dependents-set! ref-cell (cons (cons r c) (cell-dependents ref-cell)))))]
      [`(- . ,cell-coord)
       (when (pair? cell-coord)
         (define ref-r (car cell-coord))
         (define ref-c (cdr cell-coord))
         (set! new-deps (cons (cons ref-r ref-c) new-deps))
         (define ref-cell (get-cell ref-r ref-c))
         (unless (member (cons r c) (cell-dependents ref-cell) equal?)
           (cell-dependents-set! ref-cell (cons (cons r c) (cell-dependents ref-cell)))))])))
  (cell-dependencies-set! current-cell (reverse new-deps)))

(define (recalculate-cell-and-dependents start-r start-c)
  (define cells-to-recalculate (make-hash))

  (define (collect-dependents r c)
    (unless (hash-has-key? cells-to-recalculate (cons r c))
      (hash-set! cells-to-recalculate (cons r c) #t)
      (define current-cell (get-cell r c))
      (for ([dep-coord (cell-dependents current-cell)])
        (collect-dependents (car dep-coord) (cdr dep-coord)))))

  (collect-dependents start-r start-c)

  (define final-order '())
  (define visited-for-topo (make-hash))

  (define (dfs-topo r c)
    (case (hash-ref visited-for-topo (cons r c) 0)
      [2 (void)]
      [1 (error "Cycle detected during recalculation!")]
      [0
       (hash-set! visited-for-topo (cons r c) 1)

       (define current-cell (get-cell r c))
       (define content (cell-content current-cell))

       (when (string? content)
         (define terms (parse-formula content))
         (for ([term terms])
           (match term
             [`(+ . ,cell-coord)
              (when (pair? cell-coord)
                (dfs-topo (car cell-coord) (cdr cell-coord)))]
             [`(- . ,cell-coord)
              (when (pair? cell-coord)
                (dfs-topo (car cell-coord) (cdr cell-coord)))])))

       (hash-set! visited-for-topo (cons r c) 2)
       (set! final-order (cons (cons r c) final-order))]))

  (for ([coord (hash-keys cells-to-recalculate)])
    (dfs-topo (car coord) (cdr coord)))

  (for ([coord (in-list (reverse final-order))])
    (define r (car coord))
    (define c (cdr coord))
    (define current-cell (get-cell r c))
    (define content (cell-content current-cell))

    (cond
      [(number? content)
       (cell-value-set! current-cell content)]
      [(string? content)
       (define terms (parse-formula content))
       (define new-val 0)
       (for ([term terms])
         (match term
           [`(+ . ,coord-or-num)
            (cond
              [(pair? coord-or-num)
               (define ref-r (car coord-or-num))
               (define ref-c (cdr coord-or-num))
               (set! new-val (+ new-val (cell-value (get-cell ref-r ref-c))))]
              [(number? coord-or-num)
               (set! new-val (+ new-val coord-or-num))])]
           [`(- . ,coord-or-num)
            (cond
              [(pair? coord-or-num)
               (define ref-r (car coord-or-num))
               (define ref-c (cdr coord-or-num))
               (set! new-val (- new-val (cell-value (get-cell ref-r ref-c))))]
              [(number? coord-or-num)
               (set! new-val (- new-val coord-or-num))])]))
       (cell-value-set! current-cell new-val)])))

(define (Spreadsheet)
  (for* ([r (in-range 1 27)]
         [c (in-range 1 27)])
    (vector-set! (vector-ref spreadsheet-cells r) c (make-cell 0 0 '() '()))))

(define (get row col)
  (cell-value (get-cell row col)))

(define (set row col val)
  (define current-cell (get-cell row col))

  (clear-old-dependencies row col)
  (cell-content-set! current-cell val)

  (if (string? val)
      (establish-new-dependencies row col val)
      (cell-value-set! current-cell val))

  (recalculate-cell-and-dependents row col))

(define (update row col val)
  (set row col val))