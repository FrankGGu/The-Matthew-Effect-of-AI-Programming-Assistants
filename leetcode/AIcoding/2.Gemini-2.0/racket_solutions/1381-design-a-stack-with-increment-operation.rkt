(provide
 (contract-out
  [MyStack (-> exact-nonnegative-integer? (listof exact-integer?) MyStack?)]
  [push (-> MyStack? exact-integer? void?)]
  [pop (-> MyStack? (or/c exact-integer? #f))]
  [increment (-> MyStack? exact-nonnegative-integer? exact-integer? void?)]))

(define MyStack%
  (class object%
    (init max-size initial-list)
    (super-new)

    (define stack (make-vector max-size 0))
    (define size (box 0))

    (define/public (push v)
      (when (< (unbox size) max-size)
        (vector-set! stack (unbox size) v)
        (set-box! size (+ (unbox size) 1))))

    (define/public (pop)
      (if (zero? (unbox size))
          #f
          (begin
            (set-box! size (- (unbox size) 1))
            (vector-ref stack (unbox size)))))

    (define/public (increment k val)
      (for ([i (in-range (min k (unbox size)))])
        (vector-set! stack i (+ (vector-ref stack i) val)))))

    (define/public (to-list)
      (let loop ([i 0] [acc '()])
        (if (= i (unbox size))
            (reverse acc)
            (loop (+ i 1) (cons (vector-ref stack i) acc)))))
    ))

(define (MyStack max-size initial-list)
  (new MyStack% [max-size max-size] [initial-list initial-list]))

(define (push stack v)
  ((send stack push) v))

(define (pop stack)
  ((send stack pop)))

(define (increment stack k val)
  ((send stack increment) k val))