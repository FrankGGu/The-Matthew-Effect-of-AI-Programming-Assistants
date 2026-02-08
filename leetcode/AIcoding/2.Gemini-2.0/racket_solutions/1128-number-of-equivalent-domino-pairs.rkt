(define (num-equiv-domino-pairs dominoes)
  (define (normalize domino)
    (if (< (car domino) (cadr domino))
        domino
        (list (cadr domino) (car domino))))

  (define normalized-dominoes (map normalize dominoes))

  (define counts (make-hash))
  (for-each (lambda (domino)
              (let ((key (list->string (map number->string domino))))
                (hash-update! counts key (lambda (v) (+ v 1)) 0)))
            normalized-dominoes)

  (define total-pairs 0)
  (hash-for-each counts
                 (lambda (key count)
                   (set! total-pairs (+ total-pairs (/ (* count (- count 1)) 2)))))

  total-pairs)