(define (maximum-moves grid)
  (let* ([rows (vector-length grid)]
         [cols (vector-length (vector-ref grid 0))]
         [memo (build-vector rows (lambda (_) (build-vector cols (lambda (_) -1))))])

    (letrec ([dfs (lambda (r c)
                    (cond
                      [(>= c (- cols 1)) 0] ; Base case: last column
                      [(not (= (vector-ref (vector-ref memo r) c) -1)) ; Memoized
                       (vector-ref (vector-ref memo r) c)]
                      [else
                       (let* ([current-val (vector-ref (vector-ref grid r) c)]
                              [max-moves-from-here 0])
                         (for ([dr '(-1 0 1)])
                           (let ([nr (+ r dr)]
                                 [nc (+ c 1)])
                             (when (and (>= nr 0) (< nr rows)
                                        (> (vector-ref (vector-ref grid nr) nc) current-val))
                               (set! max-moves-from-here (max max-moves-from-here (+ 1 (dfs nr nc)))))))
                         (vector-set! (vector-ref memo r) c max-moves-from-here)
                         max-moves-from-here)]))])

      (let ([max-total-moves 0])
        (for ([r (in-range rows)])
          (set! max-total-moves (max max-total-moves (dfs r 0))))
        max-total-moves))))