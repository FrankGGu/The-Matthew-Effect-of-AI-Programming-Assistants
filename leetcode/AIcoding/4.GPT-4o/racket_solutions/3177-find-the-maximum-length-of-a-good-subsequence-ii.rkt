(define (maximum-length-good-subsequence arr)
  (define (good? subseq)
    (let loop ((s subseq) (last 0) (count 0))
      (cond
        [(null? s) count]
        [(> (car s) last) (loop (cdr s) (car s) (+ count 1))]
        [else (loop (cdr s) last count)])))

  (define (helper lst)
    (if (null? lst)
        0
        (max (helper (cdr lst)) (good? (cons (car lst) (cdr lst))))))

  (helper arr))

(maximum-length-good-subsequence arr)