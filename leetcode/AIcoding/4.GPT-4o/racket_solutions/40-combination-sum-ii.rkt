(define (combination-sum-ii candidates target)
  (define (backtrack start path target)
    (cond
      [(= target 0) (list path)]
      [(or (< target 0) (>= start (length candidates))) '()]
      [else
       (define results '())
       (for ([i (in-range start (length candidates))])
         (when (or (= i start) (not (= (list-ref candidates i) (list-ref candidates (- i 1)))))
           (set! results (append results (backtrack (+ i 1) (cons (list-ref candidates i) path) (- target (list-ref candidates i)))))))
       results]))
  (sort (map (lambda (x) (reverse x)) (backtrack 0 '() target)) 
        (lambda (a b) (for/and ([i (in-range (min (length a) (length b)))])
                        (if (= (list-ref a i) (list-ref b i)) #t
                            (< (list-ref a i) (list-ref b i))))))
        #:key (lambda (x) (list-ref x 0))))