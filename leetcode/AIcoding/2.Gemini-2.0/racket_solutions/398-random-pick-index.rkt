(define (make-solution nums)
  (lambda (target)
    (let loop ([i 0] [count 0] [index -1])
      (cond
        [(>= i (length nums)) index]
        [(= (list-ref nums i) target)
         (let ([new-count (+ count 1)])
           (if (= 0 (random new-count))
               (loop (+ i 1) new-count i)
               (loop (+ i 1) new-count index)))]
        [else (loop (+ i 1) count index)]))))