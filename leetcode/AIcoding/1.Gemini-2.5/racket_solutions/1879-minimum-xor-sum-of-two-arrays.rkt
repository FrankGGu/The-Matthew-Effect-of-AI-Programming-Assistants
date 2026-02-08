(define (minimum-xor-sum nums1 nums2)
  (define n (vector-length nums1))
  (define memo (make-hash))

  (define (dp i mask)
    (cond
      [(= i n) 0]
      [(hash-has-key? memo (cons i mask)) (hash-ref memo (cons i mask))]
      [else
       (let loop ((j 0) (min-val +inf.0))
         (cond
           [(= j n)
            (hash-set! memo (cons i mask) min-val)
            min-val]
           [(= (bitwise-and mask (arithmetic-shift 1 j)) 0)
            (loop (+ j 1) min-val)]
           [else
            (let* ((current-xor (bitwise-xor (vector-ref nums1 i) (vector-ref nums2 j)))
                   (next-mask (bitwise-xor mask (arithmetic-shift 1 j)))
                   (remaining-sum (dp (+ i 1) next-mask)))
              (loop (+ j 1) (min min-val (+ current-xor remaining-sum)))))]))]
  (dp 0 (sub1 (arithmetic-shift 1 n))))