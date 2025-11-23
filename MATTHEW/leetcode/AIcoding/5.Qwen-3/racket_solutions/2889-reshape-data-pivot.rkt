#lang racket

(define (pivot-table weather)
  (map (lambda (row)
         (list (list-ref row 0) (list-ref row 1) (list-ref row 2)))
       (sort (map (lambda (row)
                    (list (list-ref row 0) (list-ref row 1) (list-ref row 2)))
                  weather)
             (lambda (a b)
               (or (< (list-ref a 0) (list-ref b 0))
                   (and (= (list-ref a 0) (list-ref b 0))
                        (< (list-ref a 1) (list-ref b 1))))))))