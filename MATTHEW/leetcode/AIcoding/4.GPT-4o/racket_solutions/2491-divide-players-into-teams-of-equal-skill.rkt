(define (divide-players skill)
  (define total-skill (apply + skill))
  (define n (length skill))
  (define team-skill (/ total-skill n))
  (define pairs '())

  (define (helper skills)
    (if (null? skills)
        pairs
        (let ((first (car skills)))
          (for-each
           (lambda (second)
             (when (= (+ first second) team-skill)
               (set! pairs (cons (list first second) pairs))))
           (cdr skills))
          (helper (cdr skills)))))

  (helper skill)
  (reverse pairs))

(define (dividePlayers skill)
  (if (even? (length skill))
      (divide-players skill)
      '()))