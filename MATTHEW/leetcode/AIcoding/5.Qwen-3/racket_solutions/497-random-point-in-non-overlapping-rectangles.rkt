(define (make-rectangles rects)
  (let* ([n (length rects)]
         [prefix-sum (build-list n (lambda (i) (if (= i 0) (caar rects) (+ (list-ref prefix-sum (- i 1)) (caar (list-ref rects i))))))])
    (lambda (x)
      (let ([rand (random x)])
        (let loop ([i 0])
          (if (>= i n) #f
              (if (<= rand (list-ref prefix-sum i))
                  (let ([rect (list-ref rects i)])
                    (let ([w (- (cadr rect) (car rect))]
                          [h (- (caddr rect) (cadr rect))])
                      (cons (+ (car rect) (random w)) (+ (cadr rect) (random h)))))
                  (loop (+ i 1)))))))))

(define (random-point rects)
  ((make-rectangles rects) (apply + (map (lambda (r) (* (- (cadr r) (car r)) (- (caddr r) (cadr r)))) rects))))