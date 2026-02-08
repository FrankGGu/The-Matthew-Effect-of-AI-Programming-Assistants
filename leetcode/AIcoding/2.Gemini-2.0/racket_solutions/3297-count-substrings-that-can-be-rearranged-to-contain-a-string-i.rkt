(define (count-substrings s t)
  (let* ((n (string-length s))
         (m (string-length t))
         (target-freq (make-vector 26 0)))
    (for ((i (in-range m)))
      (vector-set! target-freq (- (char->integer (string-ref t i)) (char->integer #\a)) (+ (vector-ref target-freq (- (char->integer (string-ref t i)) (char->integer #\a))) 1)))

    (define (check freq)
      (let loop ((i 0))
        (cond
          ((= i 26) #t)
          ((> (vector-ref target-freq i) (vector-ref freq i)) #f)
          (else (loop (+ i 1))))))

    (let loop ((i 0) (count 0))
      (if (>= i n)
          count
          (let* ((freq (make-vector 26 0)))
            (for ((j (in-range i n)))
              (vector-set! freq (- (char->integer (string-ref s j)) (char->integer #\a)) (+ (vector-ref freq (- (char->integer (string-ref s j)) (char->integer #\a))) 1))
              (if (>= (- j i) (- m 1))
                  (if (check freq)
                      (set! count (+ count 1)))))
            (loop (+ i 1) count))))))