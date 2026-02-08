(define (maxFruits fruits)
  (define n (length fruits))
  (define max-fruits 0)

  (define (helper l r curr-sum)
    (if (>= r n)
        (max max-fruits curr-sum)
        (let loop ((l l) (r r) (curr-sum curr-sum) (count 0))
          (if (and (< l r) (<= count 2))
              (loop (if (< l r) l (+ l 1))
                    (+ r 1)
                    (+ curr-sum (if (< l r) (list-ref fruits r) 0))
                    (if (< l r) count (+ count 1)))
              (if (<= count 2)
                  (max max-fruits curr-sum)
                  (loop (if (< l r) l (+ l 1))
                        r
                        (- curr-sum (list-ref fruits l))
                        (if (< l r) count (- count 1))))))))

  (helper 0 0 0)
  max-fruits)

(maxFruits '((1 2) (2 1) (1 1) (2 2)))