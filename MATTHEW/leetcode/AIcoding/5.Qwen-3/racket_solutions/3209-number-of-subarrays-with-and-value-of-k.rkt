(define (at-least-one? lst)
  (not (null? lst)))

(define (subarray-and nums k)
  (let loop ([i 0] [current 0] [count 0])
    (if (= i (length nums))
        count
        (let ([new-current (bitwise-and current (list-ref nums i))])
          (if (= new-current k)
              (loop (+ i 1) (list-ref nums i) (+ count 1))
              (loop (+ i 1) new-current count))))))