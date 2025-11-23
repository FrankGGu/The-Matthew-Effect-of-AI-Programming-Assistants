#lang racket

(define RandomPicker
  (class object%
    (define/public (init (w (listof integer?)))
      (set! weights w)
      (set! prefix-sums (map (lambda (x) (if (null? x) 0 (+ (car x) (if (null? (cdr x)) 0 (last prefix-sums))))) (in-list w)))
      (set! total (last prefix-sums)))

    (define/public (pick-index)
      (define rand (random total))
      (for/fold ([i 0]) ([sum prefix-sums])
        (if (<= sum rand) 
            (add1 i) 
            (if (zero? i) 
                (error "No valid index") 
                (return i)))))

    (define/public (pick)
      (pick-index))

    (define weights '())
    (define prefix-sums '())
    (define total 0)

    (super-new)))

(define (create-random-picker w)
  (new RandomPicker [init w]))