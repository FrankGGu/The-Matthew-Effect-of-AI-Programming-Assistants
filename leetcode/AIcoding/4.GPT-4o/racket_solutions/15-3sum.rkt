(define (three-sum nums)
  (define (two-sum nums target)
    (define seen (make-hash))
    (for/fold ([result '()]) ([num nums])
      (let ([complement (- target num)])
        (if (hash-has? seen complement)
            (cons (list complement num) result)
            (begin
              (hash-set! seen num #t)
              result)))))

  (define (find-triplets nums)
    (define sorted (sort nums <))
    (for/fold ([result '()]) ([i (in-range (length sorted))])
      (define a (list-ref sorted i))
      (if (> a 0) result
          (define new-target (- 0 a))
          (define pairs (two-sum (append (subvector sorted 0 i) (subvector sorted (+ i 1) (length sorted))) new-target))
          (for/fold ([res result]) ([pair pairs])
            (cons (cons a pair) res)))))

  (remove-duplicates (find-triplets nums)))