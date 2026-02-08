(define frequency-tracker%
  (class object%
    (super-new)
    (init-field)
    (define frequencies (make-hash))
    (define freq-count (make-hash))

    (define/public (add number)
      (define old-freq (hash-ref frequencies number 0))
      (when (> old-freq 0)
        (hash-set! freq-count old-freq (sub1 (hash-ref freq-count old-freq 0))))
      (define new-freq (add1 old-freq))
      (hash-set! frequencies number new-freq)
      (hash-set! freq-count new-freq (add1 (hash-ref freq-count new-freq 0))))

    (define/public (deleteOne number)
      (define old-freq (hash-ref frequencies number 0))
      (when (> old-freq 0)
        (hash-set! freq-count old-freq (sub1 (hash-ref freq-count old-freq 0)))
        (define new-freq (sub1 old-freq))
        (hash-set! frequencies number new-freq)
        (when (> new-freq 0)
          (hash-set! freq-count new-freq (add1 (hash-ref freq-count new-freq 0)))))

    (define/public (hasFrequency frequency)
      (> (hash-ref freq-count frequency 0) 0))))

(define (make-frequency-tracker)
  (new frequency-tracker%))