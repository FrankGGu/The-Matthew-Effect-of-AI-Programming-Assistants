(define (minInteger s k)
  (define n (string-length s))
  (define digits (string->list s))
  (define pos (make-vector 10 (list)))
  (for/list ([i (in-range n)])
    (vector-set! pos (string->number (list->string (list (list-ref digits i)))) (cons i (vector-ref pos (string->number (list->string (list (list-ref digits i))))))))

  (define res "")
  (define used (make-vector n #f))
  (define swaps 0)

  (define (update-pos idx val)
    (define (update-helper i)
      (cond
        [(>= i n) #f]
        [(vector-ref used i) (update-helper (+ i 1))]
        [else (+ i val)]))
    (update-helper idx))

  (define (find-min)
    (for/first ([d (in-range 10)] #:when (not (null? (vector-ref pos d))))
      (let ([idx (car (vector-ref pos d))])
        (define real-idx (update-pos 0 idx))
        (if (and (<= real-idx (- k swaps)))
            d
            #f))))

  (define (remove-digit d)
    (define lst (vector-ref pos d))
    (vector-set! pos d (cdr lst)))

  (define (mark-used idx)
    (define real-idx (update-pos 0 idx))
    (vector-set! used real-idx #t))

  (let loop ([i 0])
    (if (= i n)
        res
        (let* ([min-digit (find-min)]
               [idx (car (vector-ref pos min-digit))]
               [real-idx (update-pos 0 idx)])
          (set! swaps (+ swaps real-idx))
          (set! res (string-append res (number->string min-digit)))
          (remove-digit min-digit)
          (mark-used idx)
          (loop (+ i 1)))))
  res)