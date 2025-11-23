(define (count-asterisks s)
  (let loop ([i 0] [inside-pair? #f] [count 0])
    (cond
      [(= i (string-length s)) count]
      [(char=? (string-ref s i) #\|)
       (loop (+ i 1) (not inside-pair?) count)]
      [(and (not inside-pair?) (char=? (string-ref s i) #\*))
       (loop (+ i 1) inside-pair? (+ count 1))]
      [else
       (loop (+ i 1) inside-pair? count)])))