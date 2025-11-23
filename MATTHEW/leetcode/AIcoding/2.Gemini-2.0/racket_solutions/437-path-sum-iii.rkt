(define (path-sum root target-sum)
  (letrec ((count-paths (lambda (node current-sum)
                          (if (null? node)
                              0
                              (+ (if (= (+ current-sum (car node)) target-sum) 1 0)
                                 (count-paths (cadr node) (+ current-sum (car node)))
                                 (count-paths (caddr node) (+ current-sum (car node)))))))
           (path-sum-helper (lambda (node)
                               (if (null? node)
                                   0
                                   (+ (count-paths node 0)
                                      (path-sum-helper (cadr node))
                                      (path-sum-helper (caddr node)))))))
    (path-sum-helper root)))