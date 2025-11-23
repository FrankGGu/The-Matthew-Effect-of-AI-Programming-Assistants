(define (minTimeToBrew potions)
  (define (binary-search lo hi)
    (if (= lo hi)
        lo
        (let ((mid (quotient (+ lo hi) 2)))
          (if (can-brew? mid potions)
              (binary-search lo mid)
              (binary-search (+ mid 1) hi)))))

  (define (can-brew? time potions)
    (define total 0)
    (for-each (lambda (p)
                (set! total (+ total (quotient time p))))
              potions)
    (>= total (length potions)))

  (binary-search 1 (apply max potions)))