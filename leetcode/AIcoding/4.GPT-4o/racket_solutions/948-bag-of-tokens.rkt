(define (bag-of-tokens tokens power)
  (define (helper tokens power)
    (if (null? tokens)
        0
        (let* ((n (length tokens))
               (tokens (sort tokens <))
               (left 0)
               (right (- n 1))
               (score 0))
          (let loop ((score score) (power power) (left left) (right right))
            (cond
              ((> left right) score)
              ((>= power (list-ref tokens left))
               (loop (+ score 1) (- power (list-ref tokens left)) (+ left 1) right))
              ((> score 0)
               (loop (- score 1) (+ power (list-ref tokens right)) left (- right 1))
              (else
               score)))))))
  (helper (sort tokens <) power))