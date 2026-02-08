(define (longest-substring s k)
  (define (helper str)
    (let ((counts (make-hash)))
      (for ([c (in-string str)])
        (hash-update! counts c (λ (v) (+ v 1)) 1))
      (define splits (list))
      (for ([c (in-string str)] [i (in-range (string-length str))])
        (when (< (hash-ref counts c 0) k)
          (set! splits (cons i splits))))
      (cond
        [(null? splits) (string-length str)]
        [else
         (let loop ([splits (reverse splits)] [start 0] [max-len 0])
           (cond
             [(null? splits)
              (max max-len (- (string-length str) start))]
             [else
              (let* ([split-idx (car splits)]
                     [sub-str (substring str start split-idx)]
                     [new-max-len (max max-len (helper sub-str))])
                (loop (cdr splits) (+ split-idx 1) new-max-len))]))]))))
  (helper s))