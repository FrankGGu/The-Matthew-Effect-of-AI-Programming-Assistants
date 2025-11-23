#lang racket

(define (find-integer-in-map m k)
  (cond [(empty? m) #f]
        [else
         (let ([key (car (hash-keys m))])
           (if (>= (hash-ref m key) 1)
               key
               (find-integer-in-map (hash-remove m key) k)))]))

(define (can-divide-into-sets nums k)
  (define freq (make-hash))
  (for-each (lambda (n) (hash-set! freq n (+ (hash-ref freq n 0) 1))) nums)
  (let loop ()
    (when (empty? (hash-keys freq)) #t)
    (let* ([start (find-integer-in-map freq k)]
           [count (hash-ref freq start)])
      (when (not start) #f)
      (for ([i (in-range k)])
        (let ([num (+ start i)])
          (when (= (hash-ref freq num 0) 0)
            (return #f)))
        (hash-update! freq (+ start i) sub1))
      (loop))))

(define (canDivideArray nums k)
  (can-divide-into-sets nums k))