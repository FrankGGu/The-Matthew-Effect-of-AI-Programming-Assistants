(define (find-common-characters words)
  (define (make-char-counts s)
    (define counts (make-vector 26 0))
    (for ([c (string->list s)])
      (define idx (- (char->integer c) (char->integer #\a)))
      (vector-set! counts idx (+ (vector-ref counts idx) 1)))
    counts)

  (define (min-counts counts1 counts2)
    (define new-counts (make-vector 26 0))
    (for ([i (in-range 26)])
      (vector-set! new-counts i (min (vector-ref counts1 i) (vector-ref counts2 i))))
    new-counts)

  (if (null? words)
      '()
      (let* ([initial-counts (make-char-counts (car words))]
             [final-counts (foldl min-counts
                                  initial-counts
                                  (cdr words))])
        (define result '())
        (for ([i (in-range 26)])
          (define char-code (+ i (char->integer #\a)))
          (define char-val (integer->char char-code))
          (define count (vector-ref final-counts i))
          (for ([_ (in-range count)])
            (set! result (cons (string (list char-val)) result))))
        (reverse result))))