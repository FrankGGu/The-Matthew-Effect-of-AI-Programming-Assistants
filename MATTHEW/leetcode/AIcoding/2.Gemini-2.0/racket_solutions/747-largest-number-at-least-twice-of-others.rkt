(define (dominantIndex nums)
  (let loop ([i 0] [max-val -1] [max-index -1])
    (if (= i (length nums))
        (if (ormap (lambda (num) (and (!= num max-val) (> (* 2 num) max-val))) nums)
            -1
            max-index)
        (if (> (list-ref nums i) max-val)
            (loop (+ i 1) (list-ref nums i) i)
            (loop (+ i 1) max-val max-index)))))