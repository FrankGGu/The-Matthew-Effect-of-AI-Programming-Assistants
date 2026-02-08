(define (getMaxRepetitions s1 n1 s2 n2)
  (define len1 (string-length s1))
  (define len2 (string-length s2))
  (define counts '())

  (define (count-reps str n)
    (let loop ((i 0) (j 0) (count 0))
      (if (>= i n)
          count
          (let ((k j))
            (let loop2 ((j k) (found 0))
              (if (>= j len1)
                  (loop (+ i 1) 0 (+ count found))
                  (if (string-ref s1 j) = (string-ref s2 found)
                      (loop2 (+ j 1) (+ found 1))
                      (loop2 (+ j 1) found))))))))

  (let loop ((i 0) (total 0))
    (if (>= i n1)
        total
        (let ((count (count-reps s1 n1)))
          (set! total (+ total (/ count n2)))
          (loop (+ i count) total))))))

(getMaxRepetitions "acb" 4 "ab" 2)