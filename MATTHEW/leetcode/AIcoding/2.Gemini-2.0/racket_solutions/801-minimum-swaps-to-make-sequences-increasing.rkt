(define (min-swap-to-make-sequences-increasing a b)
  (define n (vector-length a))
  (define swap (make-vector n 0))
  (define no-swap (make-vector n 0))

  (vector-set! swap 0 1)
  (vector-set! no-swap 0 0)

  (for ([i (in-range 1 n)])
    (define swap-i (add1 (vector-ref swap (- i 1))))
    (define no-swap-i (vector-ref no-swap (- i 1)))

    (define possible-swap-i #f)
    (define possible-no-swap-i #f)

    (cond
      ((and (< (vector-ref a (- i 1)) (vector-ref a i))
            (< (vector-ref b (- i 1)) (vector-ref b i)))
       (set! possible-swap-i swap-i)
       (set! possible-no-swap-i no-swap-i))
      (else
       (set! possible-swap-i #f)
       (set! possible-no-swap-i #f)))

    (cond
      ((and (< (vector-ref a (- i 1)) (vector-ref b i))
            (< (vector-ref b (- i 1)) (vector-ref a i)))
       (define swap-prev (vector-ref no-swap (- i 1)))
       (define no-swap-prev (add1 (vector-ref swap (- i 1))))

       (cond
         [(and possible-swap-i possible-no-swap-i)
          (set! possible-swap-i (min possible-swap-i no-swap-prev))
          (set! possible-no-swap-i (min possible-no-swap-i swap-prev))]
         [possible-swap-i
          (set! possible-swap-i (min possible-swap-i no-swap-prev))]
         [possible-no-swap-i
          (set! possible-no-swap-i (min possible-no-swap-i swap-prev))]
         [else
          (set! possible-swap-i no-swap-prev)
          (set! possible-no-swap-i swap-prev)]))
      (else
       #f))

    (cond
      [possible-swap-i
       (vector-set! swap i possible-swap-i)]
      [else
       (vector-set! swap i (+ n 1))])

    (cond
      [possible-no-swap-i
       (vector-set! no-swap i possible-no-swap-i)]
      [else
       (vector-set! no-swap i (+ n 1))]))

  (min (vector-ref swap (- n 1)) (vector-ref no-swap (- n 1))))