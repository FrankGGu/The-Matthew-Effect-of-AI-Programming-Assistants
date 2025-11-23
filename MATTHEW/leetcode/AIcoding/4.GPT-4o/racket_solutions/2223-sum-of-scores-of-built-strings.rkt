(define (sum-scores built)
  (define (score s)
    (let loop ((i 0) (j 0) (n (string-length s)) (count 0))
      (if (>= i n)
          count
          (if (string=? (substring s 0 (- n i)) (substring s i n))
              (loop (+ i 1) (+ j 1) n (+ count j))
              (loop (+ i 1) 0 n count)))))
  (apply + (map score built)))

(define (sum-of-scores built)
  (sum-scores built))