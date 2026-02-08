(define (gcd a b)
  (if (zero? b)
      a
      (gcd b (remainder a b))))

(define (number-of-different-subsequences-gcds nums)
  (let* ((max-val (apply max nums))
         (present (make-vector (+ max-val 1) #f)))
    (for-each (lambda (n) (vector-set! present n #t)) nums)

    (let loop ((g 1) (count 0))
      (if (> g max-val)
          count
          (let ((current-gcd 0))
            (let inner-loop ((k g))
              (when (<= k max-val)
                (when (vector-ref present k)
                  (set! current-gcd (gcd current-gcd k)))
                (inner-loop (+ k g))))
            (if (= current-gcd g)
                (loop (+ g 1) (+ count 1))
                (loop (+ g 1) count)))))))