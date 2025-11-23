(define (max-points energy costs bonuses)
  (define n (length costs))
  (define battles (map list costs bonuses (range n)))
  (define sorted-battles (sort battles (lambda (a b) (< (first a) (first b)))))

  (define (solve battles energy idx memo)
    (if (>= idx n)
        0
        (hash-ref! memo (list energy idx)
                   (lambda ()
                     (let* ([cost (first (list-ref battles idx))]
                            [bonus (second (list-ref battles idx))]
                            [next-idx (third (list-ref battles idx))])
                       (if (< energy cost)
                           0
                           (max (+ bonus (solve battles (+ energy bonus (- cost)) (+ idx 1) memo))
                                (solve battles energy (+ idx 1) memo))))))))

  (solve sorted-battles energy 0 (make-hash)))