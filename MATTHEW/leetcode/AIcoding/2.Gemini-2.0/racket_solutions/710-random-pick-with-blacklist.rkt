(define (make-random-pick-with-blacklist n blacklist)
  (let* ((m (length blacklist))
         (w (- n m))
         (black-set (set blacklist))
         (white-list (make-vector w)))
    (let loop ((i 0) (j 0))
      (cond
        ((= i w)
         (values w black-set white-list))
        (else
         (if (set-member? black-set j)
             (loop i (+ j 1))
             (begin
               (vector-set! white-list i j)
               (loop (+ i 1) (+ j 1))))))))

(define (random-pick-with-blacklist-pick w black-set white-list)
  (let ((k (random w)))
    (vector-ref white-list k)))

(define (random-pick-with-blacklist n blacklist)
  (let-values ([(w black-set white-list) (make-random-pick-with-blacklist n blacklist)])
    (lambda () (random-pick-with-blacklist-pick w black-set white-list))))

(provide random-pick-with-blacklist)