(define/contract (min-capability nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (can-rob max-cap)
    (let loop ([i 0] [count 0] [last-robbed -2])
      (cond
        [(>= count k) #t]
        [(>= i (length nums)) #f]
        [(and (<= (list-ref nums i) max-cap) (> (- i last-robbed) 1))
         (loop (+ i 1) (+ count 1) i)]
        [else (loop (+ i 1) count last-robbed)])))
  (let binary-search ([left 1] [right (apply max nums)])
    (if (= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (can-rob mid)
              (binary-search left mid)
              (binary-search (+ mid 1) right))))))