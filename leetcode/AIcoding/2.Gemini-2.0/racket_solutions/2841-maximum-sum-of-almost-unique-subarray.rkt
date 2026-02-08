(define (max-sum-subarray problem)
  (define nums (problem 'nums))
  (define m (problem 'm))
  (define k (problem 'k))

  (define (solve nums m k)
    (define n (length nums))
    (define (helper start end current-sum current-counts)
      (cond
        [(>= end n) current-sum]
        [else
         (define new-num (list-ref nums end))
         (define new-counts (hash-update current-counts new-num (λ (x) (+ x 1)) 1))
         (define new-unique (length (hash-keys new-counts)))
         (if (= new-unique m)
             (let [(new-sum (+ current-sum new-num))]
               (if (>= (- end start) (- k 1))
                   (let* [(old-num (list-ref nums start))
                          (updated-counts (hash-update new-counts old-num (λ (x) (- x 1))))
                          (final-counts (if (= (hash-ref updated-counts old-num) 0)
                                             (hash-remove updated-counts old-num)
                                             updated-counts))]
                     (max new-sum (helper (+ start 1) (+ end 1) (- new-sum (list-ref nums start)) final-counts)))
                   (max new-sum (helper start (+ end 1) new-sum new-counts))))
             (helper start (+ end 1) current-sum new-counts))]))

    (helper 0 0 0 (make-hash)))

  (solve nums m k))