(define (canBeValid s locked)
  (define n (string-length s))
  (if (odd? n)
      #f
      (let loop ((i 0) (open-count 0) (close-count 0) (unlocked 0))
        (cond
          ((= i n)
           (and (<= close-count (+ open-count unlocked))
                (<= open-count (+ close-count unlocked))))
          (else
           (let ((c (string-ref s i))
                 (l (string-ref locked i)))
             (cond
               ((char=? l #\1)
                (if (char=? c #\()
                    (loop (+ i 1) (+ open-count 1) close-count unlocked)
                    (loop (+ i 1) open-count (+ close-count 1) unlocked)))
               (else
                (loop (+ i 1) open-count close-count (+ unlocked 1))))))))))

(define (solve s locked)
  (canBeValid s locked))