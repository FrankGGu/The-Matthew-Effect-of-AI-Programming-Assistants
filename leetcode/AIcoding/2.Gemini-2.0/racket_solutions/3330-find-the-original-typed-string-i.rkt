(define (is-subsequence s t)
  (let loop ([s s] [t t])
    (cond
      [(empty? s) #t]
      [(empty? t) #f]
      [(equal? (first s) (first t)) (loop (rest s) (rest t))]
      [else (loop s (rest t))])))

(define (find-original-string typed)
  (let loop ([i 0] [result '()])
    (if (= i (string-length typed))
        (list->string (reverse result))
        (let ([sub (substring typed i (string-length typed))])
          (cond
            [(is-subsequence (list->string (append result (list (string-ref typed i)))) sub)
             (loop (+ i 1) (append result (list (string-ref typed i))))]
            [else
             (loop (+ i 1) result)])))))