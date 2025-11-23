(define (min-operations nums1 nums2 target)
  (define (abs x) (if (< x 0) (- x) x))
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))
  (define (lcm a b)
    (/ (* a b) (gcd a b)))
  (let loop ([i 0] [diff 0] [total 0])
    (if (= i (length nums1))
        total
        (let* ([n1 (list-ref nums1 i)]
               [n2 (list-ref nums2 i)]
               [d (abs (- n1 n2))])
          (if (= d 0)
              (loop (+ i 1) 0 total)
              (let* ([g (gcd d target)]
                     [t (lcm d target)])
                (loop (+ i 1) t (+ total (/ d g)))))))))