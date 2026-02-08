(define (numberOfSubstrings s)
  (define (count-substrings s)
    (let loop ((left 0) (right 0) (count 0) (result 0) (n (string-length s)))
      (if (= right n)
          result
          (let ((char (string-ref s right)))
            (cond
              ((or (equal? char #\a) (equal? char #\b) (equal? char #\c))
               (set! count (+ count (if (= right left) 1 0)))
               (if (and (>= count 3) (or (> right left) (equal? char #\a)))
                   (begin
                     (set! result (+ result (- left right)))
                     (loop (if (>= count 3) (add1 left) left) (add1 right) count result n))
                   (loop left (add1 right) count result n)))
              (else (loop left (add1 right) count result n)))))))
  (count-substrings s))