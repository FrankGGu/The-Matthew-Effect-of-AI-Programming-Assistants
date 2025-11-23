#lang racket

(define (nums-to-bits n)
  (let loop ([n n] [bits '()])
    (if (= n 0)
        bits
        (loop (quotient n 2) (cons (remainder n 2) bits)))))

(define (make-sorted-array target)
  (define (count-ones bits)
    (for/sum ([b bits]) b))
  (define (count-zeros bits)
    (for/sum ([b bits]) (- 1 b)))
  (define bits-list (map nums-to-bits target))
  (define max-length (apply max (map length bits-list)))
  (define padded (map (lambda (bits)
                       (append (make-list (- max-length (length bits)) 0) bits))
                     bits-list))
  (define (get-column i)
    (map (lambda (bits) (list-ref bits i)) padded))
  (define columns (map get-column (range max-length)))
  (define ones (map count-ones columns))
  (define zeros (map count-zeros columns))
  (define (process-column c)
    (if (= c 0)
        0
        (let ([ones (car c)]
              [zeros (cadr c)])
          (+ ones (if (> zeros 0) 1 0)))))
  (apply + (map process-column (map list ones zeros))))

(define (min-calls-to-make-target-array target)
  (make-sorted-array target))