(define (is-robot-bounded instructions)
  (let* ((dir-vectors '((0 . 1) (1 . 0) (0 . -1) (-1 . 0)))) ; N, E, S, W
    (let loop ((x 0)
               (y 0)
               (dir 0) ; 0: North, 1: East, 2: South, 3: West
               (idx 0))
      (if (= idx (string-length instructions))
          ;; After processing all instructions
          (or (and (= x 0) (= y 0))
              (not (= dir 0)))
          ;; Process current instruction
          (let ((instruction (string-ref instructions idx)))
            (case instruction
              ((#\G)
               (let* ((dx (car (list-ref dir-vectors dir)))
                      (dy (cdr (list-ref dir-vectors dir))))
                 (loop (+ x dx) (+ y dy) dir (+ idx 1))))
              ((#\L)
               (loop x y (modulo (- dir 1) 4) (+ idx 1)))
              ((#\R)
               (loop x y (modulo (+ dir 1) 4) (+ idx 1)))))))))