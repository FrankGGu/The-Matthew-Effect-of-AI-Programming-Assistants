(define (find-frequencies seqs)
  (define n (length seqs))
  (define map (make-hash))
  (define max-length 0)

  (for ([s seqs])
    (let ([len (length s)])
      (hash-set! map len (add1 (hash-ref map len 0)))
      (set! max-length (max max-length len))))

  (let loop ([length 1] [result '()])
    (if (> length max-length)
        result
        (begin
          (loop (add1 length) (cons (hash-ref map length 0) result)))))))

(define (f max-length seqs)
  (define result (find-frequencies seqs))
  (for ([i (in-range (length result))])
    (define val (list-ref result i))
    (when (not (= val 0))
      (display (string-append (number->string i) ": " (number->string val) "\n")))))