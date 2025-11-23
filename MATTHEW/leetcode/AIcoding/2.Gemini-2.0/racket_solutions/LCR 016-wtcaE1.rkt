(define (length-of-longest-substring s)
  (define (helper str start end char-set max-len)
    (cond
      [(>= end (string-length str)) max-len]
      [(hash-has-key? char-set (string-ref str end))
       (let loop ([i start])
         (if (equal? (string-ref str i) (string-ref str end))
             (helper str (+ i 1) (+ end 1) (hash-remove char-set (string-ref str i)) max-len)
             (begin
               (hash-remove! char-set (string-ref str i))
               (loop (+ i 1)))))]
      [else
       (hash-set! char-set (string-ref str end) #t)
       (helper str start (+ end 1) char-set (max max-len (- end start + 1)))]))

  (helper s 0 0 (make-hash) 0))