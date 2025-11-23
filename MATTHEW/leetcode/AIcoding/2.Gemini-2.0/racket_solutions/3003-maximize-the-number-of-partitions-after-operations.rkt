(define (max-partitions-after-operations nums)
  (define n (length nums))
  (define (count-different-bits x y)
    (let loop ((xor (bitwise-xor x y)) (count 0))
      (if (= xor 0)
          count
          (loop (bitwise-and xor (- xor)) (+ count 1)))))

  (define (solve mask)
    (let loop ((i 0) (current-mask 0) (partitions 1))
      (cond
        ((= i n) partitions)
        ((bitwise-ior current-mask (bitwise-and (list-ref nums i) mask))
         => (lambda (new-mask) (loop (+ i 1) new-mask partitions)))
        (else
         (loop (+ i 1) 0 (+ partitions 1))))))

  (let loop ((mask 65535) (max-partitions 1))
    (if (= mask 0)
        max-partitions
        (let ((partitions (solve mask)))
          (loop (bitwise-and (- mask 1) mask) (max max-partitions partitions))))))