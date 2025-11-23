(define (restore-ip-addresses s)
  (define (valid-segment? seg)
    (and (<= (string-length seg) 3)
         (if (> (string-length seg) 1)
             (not (char=? (string-ref seg 0) #\0))
             #t)
         (<= (string->number seg) 255)))

  (define (backtrack s start parts res)
    (cond
      [(and (= (length parts) 4) (if (= start (string-length s))
                                     (cons (string-join parts ".") res)
                                     res)]
      [(>= start (string-length s)) res]
      [else
       (let loop ([end start] [res res])
         (if (or (> end (string-length s)) (> (- end start) 3))
             res
             (let ([seg (substring s start end)])
               (if (valid-segment? seg)
                   (loop (+ end 1) (backtrack s end (append parts (list seg)) res)
                   (loop (+ end 1) res)))))]))

  (backtrack s 0 '() '()))