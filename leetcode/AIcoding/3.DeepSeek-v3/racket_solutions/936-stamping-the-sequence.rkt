(define/contract (stamp-sequence stamp target)
  (-> string? string? (listof exact-integer?))
  (define m (string-length stamp))
  (define n (string-length target))
  (define result '())
  (define changed? #t)
  (define target-list (string->list target))
  (define stamp-list (string->list stamp))

  (define (can-stamp? pos)
    (let loop ([i 0] [matched #f])
      (cond
        [(= i m) matched]
        [(char=? (string-ref target pos) #\?) #f]
        [(or (char=? (string-ref target pos) (string-ref stamp i))
             (char=? (string-ref target pos) #\?))
         (loop (+ i 1) #t)]
        [else #f])))

  (define (do-stamp pos)
    (for ([i (in-range pos (+ pos m))])
      (when (not (char=? (string-ref target i) #\?))
        (string-set! target i #\?)))
    (set! result (cons pos result)))

  (while changed?
    (set! changed? #f)
    (for ([i (in-range 0 (- n m -1))])
      (when (can-stamp? i)
        (do-stamp i)
        (set! changed? #t))))

  (if (andmap (lambda (c) (char=? c #\?)) (string->list target))
      (reverse result)
      '()))