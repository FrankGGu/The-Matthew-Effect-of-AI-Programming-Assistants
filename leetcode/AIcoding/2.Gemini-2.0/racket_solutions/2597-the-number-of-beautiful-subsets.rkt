(define (beautiful-subsets nums k)
  (letrec ((count-beautiful (lambda (idx current-subset)
                              (if (= idx (length nums))
                                  (if (empty? current-subset)
                                      0
                                      1)
                                  (let ((num (list-ref nums idx)))
                                    (+ (count-beautiful (+ idx 1) current-subset)
                                       (if (ormap (lambda (x) (or (= (+ x k) num) (= (- x k) num))) current-subset)
                                           0
                                           (count-beautiful (+ idx 1) (append current-subset (list num))))))))))
    (- (count-beautiful 0 '()) 1)))