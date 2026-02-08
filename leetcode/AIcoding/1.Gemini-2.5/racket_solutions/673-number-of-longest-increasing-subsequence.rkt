(define (find-number-of-lis nums-list)
  (let* ((n (length nums-list))
         (nums (list->vector nums-list)))

    (when (= n 0)
      (error "Input array cannot be empty")) ; Problem constraints state n >= 1

    (define dp (make-vector n 1))
    (define count (make-vector n 1))

    (for ([i (in-range n)])
      (for ([j (in-range i)])
        (when (< (vector-ref nums j) (vector-ref nums i))
          (let ((current-dp-i (vector-ref dp i))
                (current-count-i (vector-ref count i))
                (dp-j (vector-ref dp j))
                (count-j (vector-ref count j)))
            (cond
              ((> (+ dp-j 1) current-dp-i)
               (vector-set! dp i (+ dp-j 1))
               (vector-set! count i count-j))
              ((= (+ dp-j 1) current-dp-i)
               (vector-set! count i (+ current-count-i count-j))))))))

    (let ((max-len 0))
      (for ([i (in-range n)])
        (set! max-len (max max-len (vector-ref dp i))))

      (let ((total-count 0))
        (for ([i (in-range n)])
          (when (= (vector-ref dp i) max-len)
            (set! total-count (+ total-count (vector-ref count i)))))
        total-count))))