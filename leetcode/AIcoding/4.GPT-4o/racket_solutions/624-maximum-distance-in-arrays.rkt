(define (maxDistance arrays)
  (let loop ([min1 (car (car arrays))] 
             [max1 (car (car arrays))] 
             [max-dist 0])
    (for-each (lambda (arr)
                (set! max-dist (max max-dist 
                                    (abs (- (car arr) min1)) 
                                    (abs (- (car arr) max1))))
                (set! min1 (min min1 (car arr)))
                (set! max1 (max max1 (car arr))))
              (cdr arrays))
    max-dist))

(define (maximumDistance arrays)
  (maxDistance arrays))