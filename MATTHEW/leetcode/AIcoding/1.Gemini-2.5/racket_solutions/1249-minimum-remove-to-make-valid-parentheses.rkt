(define (min-remove-to-make-valid-parentheses s)
  (let* ([n (string-length s)]
         [chars (string->list s)]
         [to-remove (make-hash)]) ; Hash table to store indices of characters to remove

    ;; First pass: Identify invalid closing parentheses ')'
    ;; Iterate from left to right, tracking open parentheses count.
    (let loop-left ([i 0] [open-count 0])
      (when (< i n)
        (let ([char (list-ref chars i)])
          (cond
            [(char=? char #\()
             (loop-left (+ i 1) (+ open-count 1))]
            [(char=? char #\))
             (if (> open-count 0)
                 (loop-left (+ i 1) (- open-count 1)) ; Valid ')'
                 (begin
                   (hash-set! to-remove i #t) ; Invalid ')', mark for removal
                   (loop-left (+ i 1) open-count)))]
            [else
             (loop-left (+ i 1) open-count)]))))

    ;; Second pass: Identify invalid opening parentheses '('
    ;; Iterate from right to left, tracking close parentheses count.
    (let loop-right ([i (- n 1)] [close-count 0])
      (when (>= i 0)
        (let ([char (list-ref chars i)])
          (cond
            [(char=? char #\))
             (loop-right (- i 1) (+ close-count 1))]
            [(char=? char #\()
             (if (> close-count 0)
                 (loop-right (- i 1) (- close-count 1)) ; Valid '('
                 (begin
                   (hash-set! to-remove i #t) ; Invalid '(', mark for removal
                   (loop-right (- i 1) close-count)))]
            [else
             (loop-right (- i 1) close-count)]))))

    ;; Build the result string by filtering out marked characters
    (list->string
     (for/list ([char chars] [i (in-naturals)]
                #:unless (hash-ref to-remove i #f)) ; Only include characters not marked for removal
       char))))