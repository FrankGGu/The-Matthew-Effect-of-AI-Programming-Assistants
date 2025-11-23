(define (is-possible nums)
  (define freq (make-hash))
  (define (get-freq x) (hash-ref freq x 0))
  (for-each (lambda (x) (hash-set! freq x (+ (get-freq x) 1))) nums)
  (define (can-append x) (and (> (get-freq x) 0) (>= (get-freq (- x 1)) 1)))
  (define (append-to x) (hash-set! freq x (- (get-freq x) 1)) (hash-set! freq (+ x 1) (+ (get-freq (+ x 1)) 1)))
  (define (start-with x) (hash-set! freq x (- (get-freq x) 1)) (hash-set! freq (+ x 1) (+ (get-freq (+ x 1)) 1)) (hash-set! freq (+ x 2) (+ (get-freq (+ x 2)) 1)))
  (for-each
   (lambda (x)
     (cond
       [(> (get-freq x) 0)
        (if (can-append x)
            (append-to x)
            (begin
              (if (and (> (get-freq (+ x 1)) 0) (> (get-freq (+ x 2)) 0))
                  (begin
                    (hash-set! freq x (- (get-freq x) 1))
                    (hash-set! freq (+ x 1) (- (get-freq (+ x 1)) 1))
                    (hash-set! freq (+ x 2) (- (get-freq (+ x 2)) 1)))
                  (return #f)))]))
   nums)
  #t)