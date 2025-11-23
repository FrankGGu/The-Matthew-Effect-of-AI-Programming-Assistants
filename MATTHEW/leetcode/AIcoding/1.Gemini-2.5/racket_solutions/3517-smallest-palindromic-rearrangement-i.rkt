(require srfi/1) ; For make-list, apply append
(require srfi/13) ; For string-reverse

(define (smallest-palindromic-rearrangement s)
  (let* ([char-counts (make-hash)]
         [_ (for-each (lambda (c)
                         (hash-update! char-counts c add1 0))
                       (string->list s))]
         [first-half-char-lists '()]
         [middle-char #f])

    (for ([c-val (in-range (char->integer #\a) (add1 (char->integer #\z)))])
      (let* ([char (integer->char c-val)]
             [count (hash-ref char-counts char 0)])
        (when (> count 0)
          (let ([half-count (quotient count 2)])
            (when (> half-count 0)
              (set! first-half-char-lists (cons (make-list half-count char) first-half-char-lists))))
          (when (odd? count)
            (set! middle-char char)))))

    (let* ([first-half-chars (apply append (reverse first-half-char-lists))]
           [first-half-str (list->string first-half-chars)]
           [middle-str (if middle-char (string middle-char) "")]
           [second-half-str (string-reverse first-half-str)])
      (string-append first-half-str middle-str second-half-str))))