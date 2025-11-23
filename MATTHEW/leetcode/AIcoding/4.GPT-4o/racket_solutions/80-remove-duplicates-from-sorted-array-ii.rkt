(define (remove-duplicates nums)
  (let loop ((i 0) (count 1) (k 0))
    (if (>= i (length nums))
        k
        (begin
          (if (and (> i 0) (= (list-ref nums i) (list-ref nums (- i 1))))
              (if (< count 2)
                  (begin
                    (set! (list-ref nums k) (list-ref nums i))
                    (loop (+ i 1) (+ count 1) (+ k 1)))
                  (loop (+ i 1) count k))
              (begin
                (set! (list-ref nums k) (list-ref nums i))
                (loop (+ i 1) 1 (+ k 1))))))))

(define (remove-duplicates-wrapper nums)
  (define n (remove-duplicates nums))
  (subvector nums 0 n))