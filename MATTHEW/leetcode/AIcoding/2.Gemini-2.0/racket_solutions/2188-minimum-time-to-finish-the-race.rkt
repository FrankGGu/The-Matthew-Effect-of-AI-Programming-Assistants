(define (minimum-finish-time tires changeTime numLaps)
  (let* ((n (length tires))
         (max-lap 19)
         (dp (make-vector (add1 numLaps) +inf.0))
         (lap-times (make-vector n (make-vector (add1 max-lap) +inf.0))))

    (for ((i (in-range n)))
      (let ((f (vector-ref tires i 0))
            (r (vector-ref tires i 1)))
        (let loop ((lap 1)
                   (time f)
                   (total-time 0.0))
          (if (> lap max-lap)
              #t
              (begin
                (vector-set! (vector-ref lap-times i) lap (+ total-time time))
                (if (> r 1)
                    (loop (add1 lap) (* time r) (+ total-time time))
                    #t))))))

    (vector-set! dp 0 0.0)
    (for ((i (in-range 1 (add1 numLaps))))
      (for ((j (in-range 1 (min (add1 i) (add1 max-lap)))))
        (for ((k (in-range n)))
          (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp (- i j)) (vector-ref (vector-ref lap-times k) j) changeTime))))))

    (inexact->exact (round (- (vector-ref dp numLaps) changeTime)))))