(define (partition s)
  (define (is-palindrome? str)
    (equal? str (list->string (reverse (string->list str)))))

  (define (backtrack current-partition start)
    (cond
      [(>= start (string-length s)) (list current-partition)]
      [else
       (let loop ([i start] [result '()])
         (cond
           [(>= i (string-length s)) result]
           [else
            (let ([sub (substring s start i)])
              (if (is-palindrome? sub)
                  (append result (backtrack (append current-partition (list sub)) i))
                  result))
            (loop (+ i 1) result)]))]))

  (backtrack '() 0))