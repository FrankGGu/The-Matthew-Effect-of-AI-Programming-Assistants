(define (min-domino-rotations A B)
  (define (check-rotation target)
    (let loop ([i 0] [rotations 0])
      (cond
        [(>= i (length A)) rotations]
        [(or (= (list-ref A i) target) (= (list-ref B i) target))
         (if (= (list-ref A i) target)
             (loop (+ i 1) rotations)
             (loop (+ i 1) (+ rotations 1)))]
        [else #f])))

  (let ([n (length A)])
    (let ([rotations1 (check-rotation (list-ref A 0))]
          [rotations2 (check-rotation (list-ref B 0))])
      (cond
        [(and rotations1 rotations2) (min rotations1 rotations2)]
        [rotations1 rotations1]
        [rotations2 rotations2]
        [else -1]))))