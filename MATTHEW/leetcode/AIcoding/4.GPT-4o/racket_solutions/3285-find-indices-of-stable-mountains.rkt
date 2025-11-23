(define (findStableMountains heights)
  (define (is-stable-mountain i)
    (and (> (list-ref heights i) (list-ref heights (- i 1)))
         (> (list-ref heights i) (list-ref heights (+ i 1)))))
  (define (indices)
    (for/list ([i (in-range 1 (sub1 (length heights)))])
      (if (is-stable-mountain i)
          i
          #f)))
  (filter (lambda (x) (not (= x #f))) (indices)))

(findStableMountains '(1 3 2 4 1 5 2))