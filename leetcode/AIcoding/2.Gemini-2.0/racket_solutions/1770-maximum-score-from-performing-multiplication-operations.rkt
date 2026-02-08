(define (maximum-score nums multipliers)
  (define n (vector-length nums))
  (define m (vector-length multipliers))
  (define memo (make-hash))

  (define (solve i left)
    (if (= i m)
        0
        (let* ((right (- n 1 (- i left)))
               (key (cons i left)))
          (if (hash-has-key? memo key)
              (hash-ref memo key)
              (let ((score (+ (* (vector-ref multipliers i) (vector-ref nums left)) (solve (+ i 1) (+ left 1))))
                    (score2 (+ (* (vector-ref multipliers i) (vector-ref nums right)) (solve (+ i 1) left))))
                (hash-set! memo key (max score score2))
                (hash-ref memo key))))))

  (solve 0 0))