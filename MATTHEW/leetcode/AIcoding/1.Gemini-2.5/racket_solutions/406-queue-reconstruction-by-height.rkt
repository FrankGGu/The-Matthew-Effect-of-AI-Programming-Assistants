(define (reconstruct-queue people)
  (define (insert-at-index lst item index)
    (append (take lst index) (list item) (drop lst index)))

  (define sorted-people
    (sort people
          (lambda (p1 p2)
            (let ((h1 (first p1))
                  (k1 (second p1))
                  (h2 (first p2))
                  (k2 (second p2)))
              (or (> h1 h2)
                  (and (= h1 h2) (< k1 k2)))))))

  (define result '())

  (for-each (lambda (person)
              (set! result (insert-at-index result person (second person))))
            sorted-people)

  result)