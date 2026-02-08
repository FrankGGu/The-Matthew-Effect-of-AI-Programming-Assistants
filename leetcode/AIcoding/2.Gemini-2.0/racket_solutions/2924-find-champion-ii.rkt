(define (findChampion II n edges)
  (let* ((in-degree (make-vector n 0))
         (update-in-degree (lambda (edges)
                             (for-each (lambda (edge)
                                         (vector-set! in-degree (vector-ref edge 1) (+ (vector-ref in-degree (vector-ref edge 1)) 1)))
                                       edges)))
         (find-champion (lambda (in-degree)
                          (let loop ((i 0) (champion #f))
                            (cond
                              ((= i n) champion)
                              ((= (vector-ref in-degree i) 0)
                               (if champion
                                   #f
                                   (loop (+ i 1) i)))
                              (else (loop (+ i 1) champion)))))))
    (update-in-degree edges)
    (find-champion in-degree)))