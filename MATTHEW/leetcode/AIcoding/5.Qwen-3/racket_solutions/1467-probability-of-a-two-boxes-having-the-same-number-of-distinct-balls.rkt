#lang racket

(define (is-valid? nums)
  (let ([count (make-hash)])
    (for-each (lambda (n)
                (hash-set! count n (+ (hash-ref count n 0) 1)))
              nums)
    (= (hash-count count) (length nums))))

(define (backtrack nums start res)
  (when (= start (length nums))
    (set! res (cons (append '() nums) res))
    (void))
  (for ([i (in-range start (length nums))])
    (when (not (= (list-ref nums start) (list-ref nums i)))
      (let ([temp (list-ref nums start)])
        (set! nums (list-set nums start (list-ref nums i)))
        (set! nums (list-set nums i temp))
        (backtrack nums (+ start 1) res)
        (set! nums (list-set nums start (list-ref nums i)))
        (set! nums (list-set nums i temp)))))

(define (num-unique-balls nums)
  (let ([count (make-hash)])
    (for-each (lambda (n)
                (hash-set! count n (+ (hash-ref count n 0) 1)))
              nums)
    (hash-count count)))

(define (prob-2-boxes nums)
  (define total (factorial (length nums)))
  (define res (list))
  (backtrack nums 0 res)
  (define valid (filter (lambda (perm)
                          (let ([first-half (take perm (quotient (length perm) 2))]
                                [second-half (drop perm (quotient (length perm) 2))])
                            (= (num-unique-balls first-half) (num-unique-balls second-half))))
                        res))
  (if (null? valid)
      0.0
      (/ (length valid) total)))

(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))