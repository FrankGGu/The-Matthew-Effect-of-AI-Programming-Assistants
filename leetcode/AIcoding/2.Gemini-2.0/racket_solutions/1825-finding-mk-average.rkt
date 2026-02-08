(define (finding-mk-average m k nums)
  (define n (length nums))
  (define result (make-vector n -1))

  (define (calculate-average i)
    (let* ([sub-array (list-sort < (list->vector (subvector nums (- i k -1) (+ i k))))]
           [trimmed-array (vector->list (subvector (list->vector sub-array) k (- (length sub-array) k)))]
           [sum (apply + trimmed-array)]
           [count (length trimmed-array)])
      (if (zero? count)
          0
          (inexact->exact (floor (/ sum count))))))

  (for ([i (in-range k (- n k))])
    (when (>= i (+ k -1))
      (vector-set! result i (calculate-average i))))

  (vector->list result))

(define (mkaverage m k nums)
  (cond
    [(< (length nums) (+ m (* 2 k))) -1]
    [else (finding-mk-average m k nums)]))

(define MKAverage
  (lambda (m k)
    (let* ([nums '()]
           [sum 0]
           [count 0]
           (define (add element)
             (set! nums (append nums (list element)))
             (set! count (+ count 1))
             (if (>= count (+ m (* 2 k)))
                 (let ([result (finding-mk-average m k nums)])
                   (set! nums (cdr nums))
                   (set! count (- count 1))
                   (list-ref result (- count 1)))
                 -1))
           (define (calculate)
             (finding-mk-average m k nums)))
      (struct mkaverage-struct (add calculate) #:transparent)
      (mkaverage-struct add calculate))))

(provide MKAverage)