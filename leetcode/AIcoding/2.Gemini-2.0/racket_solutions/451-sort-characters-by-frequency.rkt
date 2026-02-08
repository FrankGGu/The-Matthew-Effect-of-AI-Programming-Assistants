(define (frequency-sort s)
  (define char-freq (make-hash))
  (for ([c (string->list s)])
    (hash-update! char-freq c add1 0))

  (define freq-chars (make-hash))
  (for ([(c freq) (in-hash char-freq)])
    (hash-update! freq-chars freq (lambda (chars) (cons c chars)) (list)))

  (define sorted-freqs (sort (hash-keys freq-chars) >))

  (define result "")
  (for ([freq sorted-freqs])
    (for ([c (hash-ref freq-chars freq)])
      (set! result (string-append result (make-string freq c)))))

  result)