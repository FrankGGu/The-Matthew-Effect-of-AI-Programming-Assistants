(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (modulo a b))))

(define (replace-non-coprime-numbers nums)
  (define result '())
  (define current 1)
  (for-each (lambda (x)
              (set! current (gcd current x))
              (if (= current 1)
                  (begin
                    (set! result (cons x result))
                    (set! current x))
                  (set! result (cons current result))))
            nums)
  (reverse result))

(define (replaceNonCoprimeNumbers nums)
  (replace-non-coprime-numbers nums))