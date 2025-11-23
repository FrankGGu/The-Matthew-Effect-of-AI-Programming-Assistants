(define (path-sum root target-sum)
  (define (count-paths node current-sum)
    (if (null? node)
        0
        (+ (if (= (+ current-sum (car node)) target-sum) 1 0)
           (count-paths (cadr node) (+ current-sum (car node)))
           (count-paths (caddr node) (+ current-sum (car node))))))

  (define (helper node)
    (if (null? node)
        0
        (+ (count-paths node 0)
           (helper (cadr node))
           (helper (caddr node)))))

  (helper root))