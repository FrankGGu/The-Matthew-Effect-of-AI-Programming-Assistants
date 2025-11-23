(define ExamRoom
  (class object%
    (super-new)
    (define/public (init N)
      (set! size N)
      (set! seats '()))

    (define size 0)
    (define seats '())

    (define/public (seat)
      (if (null? seats)
          (begin
            (set! seats (list 0))
            0)
          (let* ((dists (map (lambda (s)
                               (if (null? (cdr s))
                                   (if (null? (car s))
                                       (list (car s))
                                       (list (car s) (sub1 size)))
                                   (list (car s) (sub1 (cadr s)))))
                             (cons (list 0) (append seats (list (sub1 size))))))
                 (max-dist (apply max (map (lambda (x) (if (null? x) 0 (max (car x) (sub1 (cadr x))))) dists)))
                 (index (index-of max-dist dists)))
            (if (and (null? (cdr index)) (null? (car index)))
                (begin
                  (set! seats (cons 0 seats))
                  0)
                (let ((pos (if (null? (cdr index))
                               (car index)
                               (if (null? (car index))
                                   (car (cdr index))
                                   (+ (car (cdr index)) (quotient (sub1 (car index)) 2))))))
                  (set! seats (sort (cons pos seats) <))
                  pos))))

    (define/public (leave (p))
      (set! seats (remove (lambda (x) (= x p)) seats)))

    (super-new)))

(define exam-room (new ExamRoom))