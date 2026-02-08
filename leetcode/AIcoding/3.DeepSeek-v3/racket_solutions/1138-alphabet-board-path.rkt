(define (alphabet-board-path target)
  (let* ((board '("abcde" "fghij" "klmno" "pqrst" "uvwxy" "z"))
         (pos (make-hash))
         (result '()))
    (for ([row (in-range (length board))]
          [s (in-list board)])
      (for ([col (in-range (string-length s))]
            [c (in-string s)])
        (hash-set! pos c (cons row col))))
    (let loop ([current-row 0]
               [current-col 0]
               [target (string->list target)])
      (if (null? target)
          (list->string (reverse result))
          (let* ((c (car target))
                 (target-pos (hash-ref pos c))
                 (target-row (car target-pos))
            (let ([row-diff (- target-row current-row)]
                  [col-diff (- (cdr target-pos) current-col)])
              (cond
                [(and (eq? c #\z) (not (eq? current-row 5)))
                 (loop current-row current-col (cons #\z (cons #\u (cdr target))))]
                [(< row-diff 0)
                 (set! result (cons #\U result))
                 (loop (sub1 current-row) current-col target)]
                [(> row-diff 0)
                 (set! result (cons #\D result))
                 (loop (add1 current-row) current-col target)]
                [(< col-diff 0)
                 (set! result (cons #\L result))
                 (loop current-row (sub1 current-col) target)]
                [(> col-diff 0)
                 (set! result (cons #\R result))
                 (loop current-row (add1 current-col) target)]
                [else
                 (set! result (cons #\! result))
                 (loop current-row current-col (cdr target))])))))))