(define (min-domino-rotations A B)
  (define (check x)
    (let loop ((i 0) (rotations-a 0) (rotations-b 0))
      (cond
        ((= i (length A)) (if (and (>= rotations-a 0) (>= rotations-b 0)) (min rotations-a rotations-b) +inf.0))
        (else
          (let ((a (vector-ref A i))
                (b (vector-ref B i)))
            (if (or (= a x) (= b x))
                (loop (+ i 1) (if (= a x) (+ rotations-a 1) rotations-a) (if (= b x) (+ rotations-b 1) rotations-b))
                +inf.0))))))

  (let ((result (min (check (vector-ref A 0)) (check (vector-ref B 0)))))
    (if (= result +inf.0) -1 result)))

(define (min-domino-rotations-for-equal-row A B)
  (min-domino-rotations (vector A) (vector B)))