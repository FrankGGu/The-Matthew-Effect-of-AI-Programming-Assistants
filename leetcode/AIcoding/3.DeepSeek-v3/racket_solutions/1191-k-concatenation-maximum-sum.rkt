(define/contract (k-concatenation-max-sum arr k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define mod (expt 10 9 7))
  (define (kadane lst)
    (let loop ([lst lst] [current 0] [max-so-far 0])
      (if (null? lst)
          max-so-far
          (let ([new-current (max (car lst) (+ current (car lst)))])
            (loop (cdr lst) new-current (max max-so-far new-current))))))
  (define total (apply + arr))
  (define max-prefix
    (let loop ([lst arr] [current 0] [max-so-far 0])
      (if (null? lst)
          max-so-far
          (let ([new-current (+ current (car lst))])
            (loop (cdr lst) new-current (max max-so-far new-current))))))
  (define max-suffix
    (let loop ([lst (reverse arr)] [current 0] [max-so-far 0])
      (if (null? lst)
          max-so-far
          (let ([new-current (+ current (car lst))])
            (loop (cdr lst) new-current (max max-so-far new-current))))))
  (define kadane-arr (kadane arr))
  (define kadane-2arr (kadane (append arr arr)))
  (cond
    [(> k 1) (max kadane-arr
                  kadane-2arr
                  (+ max-suffix max-prefix (* (max 0 total) (- k 2))))]
    [else kadane-arr]))