(define (minimum-cost s)
  (define n (string-length s))
  (define (helper s i)
    (if (= i n)
        0
        (let* ((left-cost (helper (string-copy (string-set! (string-copy s) i #\0)) (+ i 1)))
               (right-cost (helper (string-copy (string-set! (string-copy s) i #\1)) (+ i 1))))
          (+ (min left-cost right-cost)
             (if (char=? (string-ref s i) #\0)
                 (string-length (substring s i n))
                 i)))))

  (helper s 0))