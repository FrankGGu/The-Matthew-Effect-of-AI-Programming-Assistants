(define (min-cost-rearrange fruits baskets)
  (let* ([n (length fruits)]
         [counts (make-hash)]
         [total-cost (λ (lst) (apply + lst))])
    (for-each (λ (x) (hash-update! counts x (λ (v) (if v (+ v 1) 1)) 0)) fruits)
    (for-each (λ (x) (hash-update! counts x (λ (v) (if v (- v 1) -1)) 0)) baskets)
    (let* ([unbalanced-keys (filter (λ (k) (not (= (hash-ref counts k 0) 0))) (hash-keys counts))]
           [positives (filter (λ (k) (> (hash-ref counts k 0) 0)) unbalanced-keys)]
           [negatives (filter (λ (k) (< (hash-ref counts k 0) 0)) unbalanced-keys)]
           [pos-sum (total-cost (map (λ (k) (hash-ref counts k 0)) positives))]
           [neg-sum (total-cost (map (λ (k) (- (hash-ref counts k 0))) negatives))]
           [min-val (min (apply min fruits) (apply min baskets))])
      (if (not (= pos-sum neg-sum))
          -1
          (let ([moves (/ pos-sum 2)])
            (min (* moves (* 2 min-val))
                 (total-cost (append (take (sort (map (λ (k) k) positives) <) moves)
                                      (take (sort (map (λ (k) k) negatives) >) moves)))))))))