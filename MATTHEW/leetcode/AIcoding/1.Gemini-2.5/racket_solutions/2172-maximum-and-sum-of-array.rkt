(define (max-and-sum-of-array nums k)
  (define n (length nums))
  (define memo (make-hash))

  (define (count-set-bits mask)
    (let loop ((m mask) (count 0))
      (if (zero? m)
          count
          (loop (bitwise-and m (sub1 m)) (add1 count)))))

  (define (dp mask)
    (cond
      ((hash-has-key? memo mask)
       (hash-ref memo mask))
      (else
       (let* ((current-num-used (count-set-bits mask))
              (current-slot-idx (quotient current-num-used 2))
              (current-slot-value (+ current-slot-idx 1)))

         (cond
           ((= current-num-used n)
            0)
           ((> current-slot-value k)
            0)
           (else
            (let loop ((i 0) (max-val 0))
              (if (= i n)
                  (begin
                    (hash-set! memo mask max-val)
                    max-val)
                  (let ((current-bit (arithmetic-shift 1 i)))
                    (if (zero? (bitwise-and mask current-bit))
                        (let* ((new-mask (bitwise-ior mask current-bit))
                               (current-num-val (list-ref nums i))
                               (contribution (bitwise-and current-num-val current-slot-value))
                               (res (+ contribution (dp new-mask))))
                          (loop (add1 i) (max max-val res)))
                        (loop (add1 i) max-val)))))))))))

  (dp 0))