(define (execute-instructions n startPos s)
  (let* ([start-row (car startPos)]
         [start-col (cadr startPos)]
         [s-len (string-length s)])

    (for/list ([i (in-range s-len)])
      (let loop ([current-r start-row]
                 [current-c start-col]
                 [instruction-idx i]
                 [executed-count 0])
        (if (>= instruction-idx s-len)
            executed-count
            (let* ([instruction (string-ref s instruction-idx)]
                   [next-r current-r]
                   [next-c current-c])
              (case instruction
                [(#\L) (set! next-c (- next-c 1))]
                [(#\R) (set! next-c (+ next-c 1))]
                [(#\U) (set! next-r (- next-r 1))]
                [(#\D) (set! next-r (+ next-r 1))])

              (if (or (< next-r 0) (>= next-r n)
                      (< next-c 0) (>= next-c n))
                  executed-count
                  (loop next-r next-c (+ instruction-idx 1) (+ executed-count 1)))))))))