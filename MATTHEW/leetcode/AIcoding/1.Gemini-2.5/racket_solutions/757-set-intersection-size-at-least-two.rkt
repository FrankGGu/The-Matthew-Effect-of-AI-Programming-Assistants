(define (intersection-size-at-least-two intervals)
  (define (compare-intervals i1 i2)
    (let ((b1 (cadr i1))
          (b2 (cadr i2)))
      (if (< b1 b2) #t
          (if (> b1 b2) #f
              (> (car i1) (car i2))))))

  (let* ((sorted-intervals (sort intervals compare-intervals))
         (ans 0)
         (p1 -1) ; Represents the smaller of the two largest points in S
         (p2 -1)) ; Represents the larger of the two largest points in S

    (for-each (lambda (interval)
                (let ((a (car interval))
                      (b (cadr interval)))
                  (cond
                    ((< p2 a) ; Neither p1 nor p2 is in [a,b]
                     (set! ans (+ ans 2))
                     (set! p1 (- b 1))
                     (set! p2 b))
                    ((< p1 a) ; Only p2 is in [a,b]
                     (set! ans (+ ans 1))
                     (set! p1 p2)
                     (set! p2 b))
                    (else ; Both p1 and p2 are in [a,b]
                     ; Do nothing
                     ))))
              sorted-intervals)
    ans))