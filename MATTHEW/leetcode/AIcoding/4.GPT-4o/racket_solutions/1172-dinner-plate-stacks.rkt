#lang racket

(define DinnerPlates
  (lambda ()
    (define plates (vector))
    (define stack-count 0)

    (define (push plate)
      (define i 0)
      (while (and (< i stack-count) (vector-ref plates i))
        (set! i (+ i 1)))
      (if (>= i stack-count)
          (begin
            (vector-set! plates stack-count (list))
            (set! stack-count (+ stack-count 1))))
      (define current-stack (vector-ref plates i))
      (set! current-stack (cons plate current-stack))
      (vector-set! plates i current-stack))

    (define (pop)
      (define i (- stack-count 1))
      (while (and (>= i 0) (null? (vector-ref plates i)))
        (set! i (- i 1)))
      (if (< i 0)
          -1
          (begin
            (define current-stack (vector-ref plates i))
            (define plate (car current-stack))
            (set! current-stack (cdr current-stack))
            (vector-set! plates i current-stack)
            plate)))

    (define (popAtStack index)
      (if (or (< index 0) (>= index stack-count))
          -1
          (begin
            (define current-stack (vector-ref plates index))
            (if (null? current-stack)
                -1
                (begin
                  (define plate (car current-stack))
                  (set! current-stack (cdr current-stack))
                  (vector-set! plates index current-stack)
                  plate)))))

    (define (get-ops)
      (list push pop popAtStack))
    get-ops))

(define dinner-plates (DinnerPlates))
(define push (car (dinner-plates)))
(define pop (cadr (dinner-plates)))
(define popAtStack (caddr (dinner-plates)))