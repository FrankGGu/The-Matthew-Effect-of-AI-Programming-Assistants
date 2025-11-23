#lang racket

(define (count-pairs-divisible-by-k nums k)
  (define (gcd a b)
    (if (zero? b)
        a
        (gcd b (modulo a b))))

  (define (get-divisors num)
    (let ((limit (floor (sqrt num))))
      (let loop ((d 1) (divs '()))
        (if (> d limit)
            (sort (remove-duplicates divs) <)
            (if (zero? (modulo num d))
                (loop (+ d 1) (cons d (cons (/ num d) divs)))
                (loop (+ d 1) divs))))))

  (define divisors-of-k (get-divisors k))
  (define freq-gcd (make-hash))
  (define total-pairs 0)

  (for ((num-i nums))
    (define g-i (gcd num-i k))
    (define target-factor (/ k g-i))

    (for ((g-j divisors-of-k))
      (when (hash-has-key? freq-gcd g-j)
        (when (zero? (modulo g-j target-factor))
          (set! total-pairs (+ total-pairs (hash-ref freq-gcd g-j))))))

    (hash-set! freq-gcd g-i (+ (hash-ref freq-gcd g-i 0) 1)))

  total-pairs)