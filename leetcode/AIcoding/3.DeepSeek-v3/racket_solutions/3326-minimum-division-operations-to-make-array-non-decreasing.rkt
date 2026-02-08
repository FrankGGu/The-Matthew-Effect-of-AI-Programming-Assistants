(define (minimum-division-operations nums)
  (let loop ([i 1] [count 0] [prev (car nums)] [max_so_far (car nums)])
    (if (>= i (length nums))
        count
        (let ([current (list-ref nums i)])
          (if (>= current prev)
              (loop (+ i 1) count current (max current max_so_far))
              (let ([new_prev (quotient max_so_far (quotient max_so_far current))])
                (loop (+ i 1) (+ count 1) new_prev new_prev)))))))