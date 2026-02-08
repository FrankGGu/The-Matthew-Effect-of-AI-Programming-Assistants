(define (rotate-90-clockwise mat)
  (let ([n (length mat)])
    (build-list n
      (lambda (new-r)
        (build-list n
          (lambda (new-c)
            (list-ref (list-ref mat (- n 1 new-c)) new-r)))))))

(define (find-rotation mat target)
  (or (equal? mat target)
      (let ([mat1 (rotate-90-clockwise mat)])
        (or (equal? mat1 target)
            (let ([mat2 (rotate-90-clockwise mat1)])
              (or (equal? mat2 target)
                  (let ([mat3 (rotate-90-clockwise mat2)])
                    (equal? mat3 target))))))))