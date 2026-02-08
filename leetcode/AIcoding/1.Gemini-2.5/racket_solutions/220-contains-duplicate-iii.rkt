(define (contains-duplicate-iii nums k t)
  (let* ([n (vector-length nums)]
         [buckets (make-hash)]
         [bucket-size (+ t 1)])
    (for/first ([i (in-range n)]
                #:when (let* ([num (vector-ref nums i)]
                               [bucket-id (floor (/ num bucket-size))])

                           (when (hash-has-key? buckets bucket-id)
                             (when (<= (abs (- num (hash-ref buckets bucket-id))) t)
                               #t))

                           (let ([prev-bucket-id (- bucket-id 1)])
                             (when (hash-has-key? buckets prev-bucket-id)
                               (when (<= (abs (- num (hash-ref buckets prev-bucket-id))) t)
                                 #t)))

                           (let ([next-bucket-id (+ bucket-id 1)])
                             (when (hash-has-key? buckets next-bucket-id)
                               (when (<= (abs (- num (hash-ref buckets next-bucket-id))) t)
                                 #t)))

                           (hash-set! buckets bucket-id num)

                           (when (>= i k)
                             (let* ([old-num (vector-ref nums (- i k))]
                                    [old-bucket-id (floor (/ old-num bucket-size))])
                               (hash-remove! buckets old-bucket-id)))
                           #f))
      #t)
    #f))