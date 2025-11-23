(define (can-partition-k-subsets nums k)
  (define sum (apply + nums))
  (if (or (zero? k) (not (zero? (modulo sum k))))
      #f
      (let* ((target (/ sum k))
             (n (length nums))
             (used (make-vector n #f)))
        (define (can-partition-helper current-sum current-k start-index)
          (cond
            ((= current-k 0) #t)
            ((= current-sum target) (can-partition-helper 0 (- current-k 1) 0))
            ((> current-sum target) #f)
            (else
             (for/or ((i (in-range start-index n)))
               (and (not (vector-ref used i))
                    (begin
                      (vector-set! used i #t)
                      (let ((result (can-partition-helper (+ current-sum (list-ref nums i)) current-k (+ i 1))))
                        (vector-set! used i #f)
                        result)))))))
        (can-partition-helper 0 k 0))))