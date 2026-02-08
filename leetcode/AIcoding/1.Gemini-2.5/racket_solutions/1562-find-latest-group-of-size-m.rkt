(define (find-latest-group-of-size-m arr m)
  (let* ((n (length arr))
         (left (make-vector (+ n 2) 0))
         (right (make-vector (+ n 2) 0))
         (num-m-groups 0)
         (ans -1))

    (for ([step (in-range n)])
      (let* ((pos (list-ref arr step))
             (left-val (vector-ref left (- pos 1)))
             (right-val (vector-ref right (+ pos 1))))

        (when (= left-val m)
          (set! num-m-groups (- num-m-groups 1)))
        (when (= right-val m)
          (set! num-m-groups (- num-m-groups 1)))

        (let ((new-len (+ 1 left-val right-val)))
          (vector-set! left (+ pos right-val) new-len)
          (vector-set! right (- pos left-val) new-len)

          (when (= new-len m)
            (set! num-m-groups (+ num-m-groups 1))))

        (when (> num-m-groups 0)
          (set! ans (+ step 1)))))
    ans))