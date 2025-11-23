#lang racket

(define/contract (find-original-array changed)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let ([freq (make-hash)])
    (for-each (lambda (x) (hash-update! freq x add1 0)) changed)
    (define sorted (sort (hash-keys freq) <))
    (define result '())
    (for-each
     (lambda (x)
       (when (> (hash-ref freq x) 0)
         (if (= (hash-ref freq (* 2 x) 0) 0)
             (set! result (append result (make-list (hash-ref freq x) x)))
             (begin
               (set! result (append result (make-list (hash-ref freq x) x)))
               (hash-set! freq (* 2 x) (- (hash-ref freq (* 2 x)) (hash-ref freq x)))
               (when (= (hash-ref freq (* 2 x) 0) 0)
                 (hash-remove! freq (* 2 x))))))
       (hash-set! freq x 0))
     sorted)
    result))