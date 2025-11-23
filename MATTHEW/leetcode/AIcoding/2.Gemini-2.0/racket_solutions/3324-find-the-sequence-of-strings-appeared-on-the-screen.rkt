(define (find-sequences words)
  (let loop ([i 0] [result '()])
    (if (= i (length words))
        (reverse result)
        (let ([word (list-ref words i)])
          (cond
            [(null? result)
             (loop (+ i 1) (cons word result))]
            [else
             (let ([last-word (car result)])
               (if (string=? word last-word)
                   (loop (+ i 1) result)
                   (loop (+ i 1) (cons word result))))])))))