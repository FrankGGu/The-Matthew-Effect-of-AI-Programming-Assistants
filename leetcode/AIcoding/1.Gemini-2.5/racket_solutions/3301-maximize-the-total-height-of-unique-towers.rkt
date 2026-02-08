#lang racket

(define (maximize-total-height-of-unique-towers max-heights)
  (define n (vector-length max-heights))

  (define left (make-vector n 0))
  (define right (make-vector n 0))

  ;; Calculate left_sums
  (define stack '()) ; stack stores indices
  (define current-sum 0)

  (for ([i (in-range n)])
    (let ([h_i (vector-ref max-heights i)])
      (begin
        (for ([_ (in-while (lambda () (and (not (null? stack))
                                            (>= (vector-ref max-heights (car stack)) h_i))))])
          (let ([j (car stack)])
            (set! stack (cdr stack))
            (let ([prev-idx (if (null? stack) -1 (car stack))])
              (set! current-sum (- current-sum (* (- j prev-idx) (vector-ref max-heights j)))))))

        (let ([prev-idx (if (null? stack) -1 (car stack))])
          (set! current-sum (+ current-sum (* (- i prev-idx) h_i))))

        (vector-set! left i current-sum)
        (set! stack (cons i stack)))))

  ;; Calculate right_sums
  (set! stack '())
  (set! current-sum 0)

  (for ([i (in-range (- n 1) -1 -1)]) ; Iterate from n-1 down to 0
    (let ([h_i (vector-ref max-heights i)])
      (begin
        (for ([_ (in-while (lambda () (and (not (null? stack))
                                            (>= (vector-ref max-heights (car stack)) h_i))))])
          (let ([j (car stack)])
            (set! stack (cdr stack))
            (let ([prev-idx (if (null? stack) n (car stack))])
              (set! current-sum (- current-sum (* (- prev-idx j) (vector-ref max-heights j)))))))

        (let ([prev-idx (if (null? stack) n (car stack))])
          (set! current-sum (+ current-sum (* (- prev-idx i) h_i))))

        (vector-set! right i current-sum)
        (set! stack (cons i stack)))))

  ;; Calculate final maximum sum
  (define max-total-height 0)
  (for ([i (in-range n)])
    (set! max-total-height (max max-total-height
                                 (- (+ (vector-ref left i) (vector-ref right i))
                                    (vector-ref max-heights i)))))
  max-total-height)