(define/contract (sort-by-bits arr)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define (count-ones n)
    (if (zero? n)
        0
        (+ (bitwise-and n 1) (count-ones (arithmetic-shift n -1)))))
  (sort arr (lambda (a b)
              (let ([ca (count-ones a)]
                    [cb (count-ones b)])
                (or (< ca cb)
                    (and (= ca cb) (< a b)))))))