(define/contract (max-total-reward reward-array)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([rewards (sort reward-array <)]
             [total 0]
             [seen (set)])
    (if (null? rewards)
        total
        (let ([current (car rewards)])
          (if (set-member? seen current)
              (loop (cdr rewards) total seen)
              (let ([new-total (+ total current)])
                (if (> current new-total)
                    (loop (cdr rewards) total seen)
                    (loop (cdr rewards) new-total (set-add seen new-total))))))))