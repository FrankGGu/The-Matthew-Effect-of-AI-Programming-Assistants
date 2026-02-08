(define (smallestNumber pattern)
  (define (helper pattern)
    (let loop ((i 0) (stack '()) (result '()))
      (if (>= i (length pattern))
          (begin
            (set! result (append result (reverse stack)))
            (apply string-append (map number->string result)))
          (begin
            (set! stack (cons (+ i 1) stack))
            (if (equal? (string-ref pattern i) #\I)
                (begin
                  (set! result (append result (reverse stack)))
                  (set! stack '()))
                (loop (+ i 1) stack result))
            (loop (+ i 1) stack result)))))
  (helper pattern))

(smallestNumber "IIIDIDDD")