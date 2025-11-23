(define (number-of-ways start-pos end-pos k)
  (define memo (make-hash))

  (define (solve current-pos moves-left)
    (cond
      [(hash-has-key? memo (list current-pos moves-left))
       (hash-ref memo (list current-pos moves-left))]
      [(= moves-left 0)
       (if (= current-pos end-pos) 1 0)]
      [(< moves-left 0) 0]
      [else
       (let* ([left (solve (- current-pos 1) (- moves-left 1))]
              [right (solve (+ current-pos 1) (- moves-left 1))]
              [result (modulo (+ left right) 1000000007)])
         (hash-set! memo (list current-pos moves-left) result)
         result)]))

  (solve start-pos k))