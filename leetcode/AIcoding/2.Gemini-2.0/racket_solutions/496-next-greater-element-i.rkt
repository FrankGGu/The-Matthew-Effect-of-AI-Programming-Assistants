(define (next-greater-element nums1 nums2)
  (define (find-next-greater n nums)
    (let loop ([nums nums] [found? #f])
      (cond
        [(empty? nums) -1]
        [(and (not found?) (= n (car nums))) (loop (cdr nums) #t)]
        [(and found? (> (car nums) n)) (car nums)]
        [else (loop (cdr nums) found?)])))

  (map (lambda (n) (find-next-greater n nums2)) nums1))