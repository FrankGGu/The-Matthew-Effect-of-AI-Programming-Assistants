(define (min-deletion-size strs)
  (let* ((n (length strs))
         (m (string-length (first strs)))
         (ans 0)
         (keep (make-vector n #t)))
    (for ((j (in-range m)))
      (let ((new-keep (make-vector n #t)))
        (let loop ((i 0))
          (cond
            ((= i (- n 1)) #t)
            (else
             (cond
               ((and (vector-ref keep i) (char>=? (string-ref (list-ref strs i) j) (string-ref (list-ref strs (+ i 1)) j)))
                (vector-set! new-keep (+ i 1) #f)
                (loop (+ i 1)))
               (else
                (loop (+ i 1)))))))
        (let ((can-keep #t))
          (for ((i (in-range n)))
            (when (not (or (vector-ref keep i) (vector-ref new-keep i)))
              (set! can-keep #f)
              (break)))
          (if can-keep
              (for ((i (in-range n)))
                (set! (vector-ref keep i) (or (vector-ref keep i) (vector-ref new-keep i))))
              (begin
                (set! ans (+ ans 1)))))))
    ans))