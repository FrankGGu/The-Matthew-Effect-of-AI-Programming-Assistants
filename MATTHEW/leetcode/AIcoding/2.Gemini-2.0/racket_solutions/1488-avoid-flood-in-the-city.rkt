(define (avoid-flood rains)
  (let* ((n (length rains))
         (ans (make-vector n -1))
         (full-lakes (make-hash))
         (dry-days '()))
    (for/list ((i (in-range n)))
      (let ((rain (list-ref rains i)))
        (cond
          ((= rain 0)
           (set! dry-days (cons i dry-days))
           -1)
          (else
           (if (hash-has-key? full-lakes rain)
               (let loop ((dry-days dry-days))
                 (cond
                   ((null? dry-days)
                    (return (list)))
                   (else
                    (let ((dry-day (car dry-days)))
                      (if (> dry-day (hash-ref full-lakes rain))
                          (begin
                            (vector-set! ans dry-day rain)
                            (hash-remove! full-lakes rain)
                            (set! dry-days (cdr dry-days))
                            (set! dry-days (remove dry-day (cdr dry-days))))
                          (loop (cdr dry-days))))))
                 (return (list)))

               (begin
                 (hash-set! full-lakes rain i)
                 (vector-set! ans i -1)
                 -1))))))
    (for/list ((i (in-range n)))
      (if (= (vector-ref ans i) -1)
          1
          (vector-ref ans i)))))