(define (find-in-mountain-array target mountain-array)
  (define (binary-search left right)
    (if (> left right)
        -1
        (let* ((mid (quotient (+ left right) 2))
               (mid-value (list-ref mountain-array mid)))
          (cond
            ((= mid-value target) mid)
            ((< mid-value target) (binary-search (+ mid 1) right))
            (else (binary-search left (- mid 1)))))))

  (define (find-peak left right)
    (if (> left right)
        -1
        (let* ((mid (quotient (+ left right) 2))
               (mid-value (list-ref mountain-array mid))
               (next-value (if (< mid (+ 1 right)) (list-ref mountain-array (+ mid 1)) -1)))
          (cond
            ((and (> mid-value (if (> mid 0) (list-ref mountain-array (- mid 1)) -1)) 
                  (> mid-value next-value)) mid)
            ((> mid-value next-value) (find-peak (+ mid 1) right))
            (else (find-peak left (- mid 1)))))))

  (define peak (find-peak 0 (- (length mountain-array) 1)))
  (if (negative? peak) -1
      (let ((result (binary-search 0 peak)))
        (if (negative? result) (binary-search (+ peak 1) (- (length mountain-array) 1)) result))))

(define (findInMountainArray target mountain-array)
  (find-in-mountain-array target mountain-array))