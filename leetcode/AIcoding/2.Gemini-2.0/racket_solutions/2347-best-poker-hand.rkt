(define (best-poker-hand ranks suits)
  (let* ((rank-counts (make-hash))
         (suit-counts (make-hash))
         (rank-max 0)
         (suit-max 0))

    (for-each (lambda (r s)
                (hash-update! rank-counts r (lambda (v) (+ v 1)) 1)
                (hash-update! suit-counts s (lambda (v) (+ v 1)) 1))
              ranks suits)

    (hash-for-each rank-counts (lambda (k v) (set! rank-max (max rank-max v))))
    (hash-for-each suit-counts (lambda (k v) (set! suit-max (max suit-max v))))

    (cond
      [(or (= suit-max 5) (= (length (remove-duplicates suits)) 1)) "Flush"]
      [(= rank-max 4) "Four of a Kind"]
      [(= rank-max 3) "Three of a Kind"]
      [(= rank-max 2) (if (> (length (filter (lambda (x) (= x 2)) (hash-values rank-counts))) 1) "Two Pair" "Pair")]
      [else "High Card"])))