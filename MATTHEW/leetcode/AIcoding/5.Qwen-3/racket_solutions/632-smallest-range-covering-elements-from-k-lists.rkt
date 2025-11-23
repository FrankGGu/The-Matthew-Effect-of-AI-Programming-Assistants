#lang racket

(define (smallest-range-covering-elements-from-k-lists lists)
  (define k (length lists))
  (define all-elements
    (for/fold ([acc '()]) ([i (in-range k)])
      (append acc (map (lambda (x) (list x i)) (list-ref lists i)))))
  (define sorted-elements
    (sort all-elements (lambda (a b) (< (car a) (car b)))))
  (define (helper elements start end)
    (cond [(= start end) (list (car (list-ref elements start)) (car (list-ref elements start)))]
          [else
           (let loop ([left 0] [right 0] [count 0] [freq (make-hash)] [min-range (list +inf.0 -inf.0)])
             (if (>= right (length elements))
                 (if (= count k)
                     (let ([current-range (list (- (car (list-ref elements right-1)) (car (list-ref elements left))) (car (list-ref elements left)) (car (list-ref elements right-1)))]
                           (if (< (car current-range) (car min-range))
                               current-range
                               min-range))
                     min-range)
                 (let* ([current (list-ref elements right)]
                        [val (car current)]
                        [list-id (cadr current)])
                   (if (hash-has-key? freq list-id)
                       (hash-set! freq list-id (+ (hash-ref freq list-id) 1))
                       (begin (hash-set! freq list-id 1) (set! count (+ count 1))))
                   (let ([new-min-range (if (= count k)
                                            (let ([current-range (list (- val (car (list-ref elements left))) (car (list-ref elements left)) val)])
                                              (if (< (car current-range) (car min-range))
                                                  current-range
                                                  min-range))
                                            min-range)])
                     (loop left right count freq new-min-range))))))]))
  (let ([sorted (sort all-elements (lambda (a b) (< (car a) (car b))))])
    (let ([res (helper sorted 0 (length sorted))])
      (list (cadr res) (caddr res)))))