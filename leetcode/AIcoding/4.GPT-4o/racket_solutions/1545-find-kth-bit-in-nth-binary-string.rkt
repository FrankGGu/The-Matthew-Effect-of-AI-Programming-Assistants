(define (findKthBit n k)
  (define (generate s)
    (if (= s 1) "0"
        (let* ((prev (generate (- s 1)))
               (rev (string-append (reverse prev) "1")))
          (string-append prev rev))))

  (define (kth-bit s k)
    (string-ref (generate s) (- k k)))

  (kth-bit n k))