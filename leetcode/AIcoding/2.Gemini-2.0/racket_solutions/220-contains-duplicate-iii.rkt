(define (contains-nearby-almost-duplicate nums k t)
  (define (bucket x)
    (if (negative? x)
        (quotient (+ x 1) (+ t 1))
        (quotient x (+ t 1))))

  (define (helper nums k t buckets i)
    (cond
      [(empty? nums) #f]
      [else
       (let* ([num (car nums)]
              [b (bucket num)])
         (cond
           [(hash-has-key? buckets b) #t]
           [(and (hash-has-key? buckets (+ b 1))
                 (<= (abs (- num (hash-ref buckets (+ b 1)))) t))
            #t]
           [(and (hash-has-key? buckets (- b 1))
                 (<= (abs (- num (hash-ref buckets (- b 1)))) t))
            #t]
           [else
            (let ([new-buckets (hash-set buckets b num)])
              (if (> i k)
                  (let ([remove-num (list-ref (cdr (reverse nums)) k)])
                    (let ([remove-bucket (bucket remove-num)])
                      (helper (cdr nums) k t (hash-remove new-buckets remove-bucket) (+ i 1))))
                  (helper (cdr nums) k t new-buckets (+ i 1))))]))]))

  (helper nums k t (hash) 0))