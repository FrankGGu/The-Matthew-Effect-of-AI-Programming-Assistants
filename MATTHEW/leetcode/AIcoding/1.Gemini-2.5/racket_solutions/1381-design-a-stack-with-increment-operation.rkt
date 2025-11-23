#lang racket/base

(struct custom-stack (max-size current-size stack) #:mutable)

(define (make-custom-stack maxSize)
  (custom-stack maxSize 0 (make-vector maxSize 0)))

(define (custom-stack-push! this x)
  (when (< (custom-stack-current-size this) (custom-stack-max-size this))
    (vector-set! (custom-stack-stack this) (custom-stack-current-size this) x)
    (set-custom-stack-current-size! this (+ (custom-stack-current-size this) 1))))

(define (custom-stack-pop! this)
  (if (> (custom-stack-current-size this) 0)
      (let* ([current-idx (- (custom-stack-current-size this) 1)]
             [val (vector-ref (custom-stack-stack this) current-idx)])
        (set-custom-stack-current-size! this current-idx)
        val)
      -1))

(define (custom-stack-increment! this k val)
  (let ([limit (min k (custom-stack-current-size this))])
    (for ([i (in-range limit)])
      (vector-set! (custom-stack-stack this) i
                   (+ (vector-ref (custom-stack-stack this) i) val)))))