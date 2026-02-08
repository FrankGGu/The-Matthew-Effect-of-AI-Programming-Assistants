(define (decode-string s)
  (define (decode-helper str i)
    (let loop ([i i] [res ""])
      (cond
        [(>= i (string-length str)) (values res i)]
        [(char-numeric? (string-ref str i))
         (let loop2 ([j i] [num ""])
           (if (char-numeric? (string-ref str j))
               (loop2 (+ j 1) (string-append num (string (string-ref str j))))
               (let-values ([(decoded-str next-i) (decode-helper str (+ j 1))])
                 (loop next-i (string-append res (make-string (string->number num) (string-ref decoded-str 0)))))))]
        [(char=? (string-ref str i) #\]) (values res (+ i 1))]
        [else (loop (+ i 1) (string-append res (string (string-ref str i))))])))
  (car (decode-helper s 0)))