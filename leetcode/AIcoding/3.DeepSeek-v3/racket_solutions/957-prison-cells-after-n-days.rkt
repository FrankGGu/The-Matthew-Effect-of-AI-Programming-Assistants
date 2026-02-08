(define (prison-after-n-days cells n)
  (let loop ([cells cells]
             [n n]
             [seen (make-hash)])
    (cond
      [(zero? n) cells]
      [else
       (let* ([next (vector-copy cells)]
              [key (vector->list cells)])
         (hash-set! seen key (- n 1))
         (for ([i (in-range 1 (- (vector-length cells) 1))])
           (vector-set! next i 
                        (if (= (vector-ref cells (- i 1)) 
                             (vector-ref cells (+ i 1))
                            1 0)))
         (vector-set! next 0 0)
         (vector-set! next (- (vector-length cells) 1) 0)
         (let ([new-key (vector->list next)])
           (if (hash-has-key? seen new-key)
               (let ([cycle-length (- (hash-ref seen key) (hash-ref seen new-key))])
                 (loop next (remainder n cycle-length) seen))
               (loop next (- n 1) seen))))])))