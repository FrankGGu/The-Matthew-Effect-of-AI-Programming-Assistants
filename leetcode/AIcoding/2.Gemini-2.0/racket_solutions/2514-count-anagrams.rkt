(define (count-anagrams s)
  (define MOD 1000000007)
  (define (factorial n)
    (let loop ([i n] [acc 1])
      (if (= i 0)
          acc
          (loop (- i 1) (modulo (* acc i) MOD)))))
  (define (mod-inverse a m)
    (let loop ([a a] [m m] [x 1] [y 0])
      (if (= m 1)
          x
          (let ([q (quotient a m)]
                [t a])
            (set! a m)
            (set! m (modulo t m))
            (set! t x)
            (set! x y)
            (set! y (- t (* q y)))
            (loop a m x y)))))
  (define (count-anagrams-helper words)
    (let* ([n (string-length words)]
           [freq (make-hash)]
           [_ (for ([i (in-range n)])
                (let ([c (string-ref words i)])
                  (hash-update! freq c (λ (v) (+ v 1)) 1)))]
           [numerator (factorial n)]
           [denominator 1])
      (for-each (λ (k v) (set! denominator (modulo (* denominator (factorial v)) MOD))) (hash->list freq))
      (modulo (* numerator (mod-inverse denominator MOD)) MOD)))
  (let ([words (string-split s)])
    (let loop ([words words] [acc 1])
      (if (null? words)
          acc
          (loop (cdr words) (modulo (* acc (count-anagrams-helper (car words))) MOD))))))