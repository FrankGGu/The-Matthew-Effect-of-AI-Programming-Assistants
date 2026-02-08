(define k-largest
  (lambda (k)
    (let ((stream '()))
      (define (add num)
        (set! stream (cons num stream))
        (set! stream (take (sort stream >) k)))
      (define (get-kth)
        (if (null? stream)
            (error "Stream is empty")
            (car stream)))
      (values add get-kth))))

(define-values (add get-kth) (k-largest 3))
(add 4)
(add 5)
(add 8)
(get-kth) ; should return 4
(add 2)
(get-kth) ; should return 5
(add 10)
(get-kth) ; should return 8