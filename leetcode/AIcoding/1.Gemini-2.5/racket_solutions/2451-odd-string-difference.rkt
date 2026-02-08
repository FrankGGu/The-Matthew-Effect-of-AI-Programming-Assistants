(define (get-difference-array word)
  (let* ([chars (string->list word)]
         [n (length chars)])
    (for/list ([i (in-range 1 n)])
      (- (char->integer (list-ref chars i))
         (char->integer (list-ref chars (- i 1)))))))

(define (odd-string words)
  (let ([diff-map (make-hash equal?)])
    (for ([word words])
      (let ([diff-arr (get-difference-array word)])
        (hash-update! diff-map diff-arr (lambda (lst) (cons word lst)) '())))

    (let loop ([keys (hash-keys diff-map)])
      (let* ([current-key (car keys)]
             [word-list (hash-ref diff-map current-key)])
        (if (= (length word-list) 1)
            (car word-list)
            (loop (cdr keys)))))))