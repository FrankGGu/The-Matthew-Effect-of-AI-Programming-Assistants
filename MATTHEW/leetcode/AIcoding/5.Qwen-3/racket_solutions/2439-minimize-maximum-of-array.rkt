(define (split-array nums m)
  (define (can-split max-val)
    (let loop ((current 0) (count 1))
      (cond ((= count m) #t)
            ((> current (length nums)) #f)
            ((> (+ (list-ref nums current) current) max-val)
             (loop (+ current 1) (+ count 1)))
            (else
             (loop (+ current 1) count)))))
  (let loop ((left 0) (right (apply + nums)))
    (if (= left right)
        left
        (let ((mid (quotient (+ left right) 2)))
          (if (can-split mid)
              (loop left mid)
              (loop (+ mid 1) right))))))

(define (minimize-maximum nums)
  (split-array nums (length nums)))