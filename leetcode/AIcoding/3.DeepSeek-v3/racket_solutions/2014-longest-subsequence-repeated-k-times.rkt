(define/contract (longest-subsequence-repeated-k-times s k)
  (-> string? exact-integer? string?)
  (define n (string-length s))
  (define freq (make-hash))
  (for ([c s])
    (hash-update! freq c add1 0))
  (define possible-chars
    (for/list ([(c cnt) freq] #:when (>= cnt k)) c))
  (define possible-chars-list (sort possible-chars char>?))
  (define max-len (quotient n k))
  (define result "")

  (define (is-subseq? t)
    (let loop ([i 0] [j 0])
      (cond
        [(= j (string-length t)) #t]
        [(= i n) #f]
        [(char=? (string-ref s i) (string-ref t j))
         (loop (add1 i) (add1 j))]
        [else (loop (add1 i) j)])))

  (let outer ([len max-len])
    (when (>= len 1)
      (define candidates (generate-candidates possible-chars-list len))
      (let inner ([lst candidates])
        (when (not (null? lst))
          (define candidate (car lst))
          (if (is-valid-candidate? candidate k)
              (set! result candidate)
              (begin
                (inner (cdr lst))
                (outer (sub1 len))))))))
  (if (string=? result "") "" result))

(define (generate-candidates chars len)
  (if (= len 0)
      '("")
      (for*/list ([c chars]
                  [prev (generate-candidates chars (sub1 len))])
        (string-append (string c) prev))))

(define (is-valid-candidate? candidate k)
  (let loop ([i 0] [cnt 0])
    (cond
      [(= cnt k) #t]
      [(>= i (string-length candidate)) #f]
      [else
       (let ([next-i (substring-index candidate (substring candidate i))])
         (if next-i
             (loop (add1 next-i) (add1 cnt))
             #f))])))

(define (substring-index pattern str [start 0])
  (let ([m (string-length pattern)]
        [n (string-length str)])
    (let loop ([i start] [j 0])
      (cond
        [(= j m) (- i m)]
        [(>= i n) #f]
        [(char=? (string-ref str i) (string-ref pattern j))
         (loop (add1 i) (add1 j))]
        [else (loop (add1 i) 0)]))))