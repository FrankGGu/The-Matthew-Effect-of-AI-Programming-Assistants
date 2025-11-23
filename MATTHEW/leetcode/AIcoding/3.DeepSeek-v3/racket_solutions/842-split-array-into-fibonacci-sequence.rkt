(define (splitIntoFibonacci num)
  (define (helper s start path)
    (if (>= start (string-length s))
        (if (>= (length path) 3) path '())
        (let loop ([i start] [sum (if (< (length path) 2) 0 (+ (list-ref path (- (length path) 2)) (list-ref path (- (length path) 1))))] [res '()])
          (if (>= i (string-length s))
              res
              (let* ([sub (substring s start (+ i 1))]
                     [val (string->number sub)])
                (cond
                  [(or (> val 2147483647) (and (> (string-length sub) 1) (char=? (string-ref sub 0) #\0))) (loop (+ i 1) sum res)]
                  [(or (< (length path) 2) (= val sum)) 
                   (let ([new-res (helper s (+ i 1) (append path (list val)))])
                     (if (not (null? new-res)) 
                         new-res
                         (loop (+ i 1) sum res)))]
                  [(> val sum) res]
                  [else (loop (+ i 1) sum res)]))))))
  (let ([result (helper num 0 '())])
    (if (null? result) '() result)))