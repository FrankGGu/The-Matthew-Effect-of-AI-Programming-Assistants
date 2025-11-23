(define (shortest-to-char s c)
  (let* ((n (string-length s))
         (ans (make-vector n 0)))

    ;; Pass 1: Left to Right
    (let loop-left ((i 0) (prev-c-idx -20000)) ; A value guaranteed to be far left
      (when (< i n)
        (let ((current-prev-c-idx (if (char=? (string-ref s i) c) i prev-c-idx)))
          (vector-set! ans i (- i current-prev-c-idx))
          (loop-left (+ i 1) current-prev-c-idx))))

    ;; Pass 2: Right to Left
    (let loop-right ((i (- n 1)) (next-c-idx 20000)) ; A value guaranteed to be far right
      (when (>= i 0)
        (let ((current-next-c-idx (if (char=? (string-ref s i) c) i next-c-idx)))
          (vector-set! ans i (min (vector-ref ans i) (- current-next-c-idx i)))
          (loop-right (- i 1) current-next-c-idx))))

    ans))