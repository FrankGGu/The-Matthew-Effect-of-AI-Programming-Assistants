(define (number-of-weak-characters properties)
  ;; Sort properties:
  ;; Primary sort: attack descending
  ;; Secondary sort: defense ascending (if attacks are equal)
  (define properties-sorted
    (sort properties
          (lambda (p1 p2)
            (let ((a1 (car p1))
                  (d1 (cadr p1))
                  (a2 (car p2))
                  (d2 (cadr p2)))
              (cond
                ((> a1 a2) #t) ; p1 comes before p2 if a1 > a2
                ((< a1 a2) #f) ; p1 comes after p2 if a1 < a2
                (else (< d1 d2))))))) ; p1 comes before p2 if a1 == a2 and d1 < d2

  (define weak-count 0)
  (define max-defense 0) ; Stores the maximum defense encountered so far

  (for ([char properties-sorted])
    (let ((defense (cadr char)))
      (when (< defense max-defense)
        (set! weak-count (+ weak-count 1)))
      (set! max-defense (max max-defense defense))))

  weak-count)