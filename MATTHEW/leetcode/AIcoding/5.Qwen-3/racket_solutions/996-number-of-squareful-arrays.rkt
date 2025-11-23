#lang racket

(define (is-squareful? lst)
  (cond [(< (length lst) 2) #t]
        [else
         (let ([a (car lst)]
               [b (cadr lst)])
           (let ([s (+ a b)])
             (let ([sqrt-s (integer-sqrt s)])
               (= (* sqrt-s sqrt-s) s))))]))

(define (num-squareful-arrays nums)
  (define n (length nums))
  (define freq (make-hash))
  (for-each (lambda (x) (hash-update! freq x add1 0)) nums)
  (define result 0)
  (define (backtrack path used)
    (when (>= (length path) 2)
      (when (is-squareful? path)
        (set! result (+ result 1))))
    (for ([i (in-range n)]
          #:when (not (hash-ref used i #f)))
      (let ([num (list-ref nums i)])
        (when (or (null? path)
                  (is-squareful? (append path (list num))))
          (hash-set! used i #t)
          (backtrack (append path (list num)) used)
          (hash-set! used i #f))))
  (backtrack '() (make-hash))
  result)