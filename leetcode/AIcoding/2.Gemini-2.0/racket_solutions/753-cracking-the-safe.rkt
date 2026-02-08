(define (crack-safe n k)
  (define (find-path cur-path visited)
    (if (= (expt k n) (length visited))
        cur-path
        (for/first ([i (in-range k)])
          #:when (not (hash-ref! visited (string->number (string-append (substring cur-path (- (string-length cur-path) (- n 1)) (string-length cur-path)) (number->string i))) #f))
          (let* ([new-node (string-append (substring cur-path (- (string-length cur-path) (- n 1)) (string-length cur-path)) (number->string i))]
                 [new-path (string-append cur-path (number->string i))]
                 [new-visited (hash-set visited (string->number new-node) #t)])
            (find-path new-path new-visited)))))

  (define start-node (make-string n #\0))
  (define visited (make-hash))
  (for ([i (in-range (expt k (- n 1)))])
    (hash-set! visited (string->number (make-string n #\0)) #t))

  (let ([result (find-path start-node visited)])
    (substring result 0 (+ (expt k n) (- n 1)))))