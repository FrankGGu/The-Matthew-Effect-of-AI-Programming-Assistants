#lang racket

(define (find-winning-players skill strength)
  (let* ([n (vector-length skill)]
         [winning-count 0])
    (for ([i (in-range n)])
      (let ([is-winning-player? #t])
        (let ([skill-i (vector-ref skill i)]
              [strength-i (vector-ref strength i)])
          (for ([j (in-range n)])
            (when (not (= i j))
              (let ([skill-j (vector-ref skill j)]
                    [strength-j (vector-ref strength j)])
                (unless
                    (or (and (>= skill-i skill-j) (>= strength-i strength-j))
                        (and (< skill-i skill-j) (> strength-i strength-j)))
                  (set! is-winning-player? #f)
                  (break))))))
        (when is-winning-player?
          (set! winning-count (+ winning-count 1)))))
    winning-count))