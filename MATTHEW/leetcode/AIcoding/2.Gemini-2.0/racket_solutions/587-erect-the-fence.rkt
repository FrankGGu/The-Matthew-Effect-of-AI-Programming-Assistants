(define (cross-product p1 p2 p3)
  (- (* (- (car p2) (car p1)) (- (cadr p3) (cadr p1)))
     (* (- (car p3) (car p1)) (- (cadr p2) (cadr p1)))))

(define (outer-trees points)
  (let* ([n (length points)]
         [points (sort points < #:key (lambda (p) (list (car p) (cadr p))))])
    (if (<= n 3)
        points
        (let loop ([i 1]
                   [upper (list (car points) (list-ref points 1))]
                   [lower (list (car points) (list-ref points 1))])
          (if (= i (- n 1))
              (let ([hull (remove-duplicates (append upper (reverse (cdr lower))))])
                (sort hull < #:key (lambda (p) (list (car p) (cadr p)))))
              (let* ([p (list-ref points (add1 i))]
                     [upper (let loop ([lst upper])
                               (if (<= (length lst) 1)
                                   (cons p lst)
                                   (if (>= (cross-product (list-ref lst (- (length lst) 2)) (list-ref lst (- (length lst) 1)) p) 0)
                                       (loop (drop-right lst 1))
                                       (cons p lst)))))
                     [lower (let loop ([lst lower])
                               (if (<= (length lst) 1)
                                   (cons p lst)
                                   (if (<= (cross-product (list-ref lst (- (length lst) 2)) (list-ref lst (- (length lst) 1)) p) 0)
                                       (loop (drop-right lst 1))
                                       (cons p lst))))])
                (loop (add1 i) upper lower)))))))