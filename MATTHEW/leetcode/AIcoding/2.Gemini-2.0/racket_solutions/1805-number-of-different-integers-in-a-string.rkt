(define (num-different-integers s)
  (define (extract-integers str)
    (let loop ([str str] [acc '()])
      (cond
        [(string=? str "") (reverse acc)]
        [(char-numeric? (string-ref str 0))
         (let-values ([(num rest) (read-number str)])
           (loop rest (cons num acc)))]
        [else (loop (substring str 1) acc)])))

  (define (read-number str)
    (let loop ([str str] [num ""])
      (cond
        [(string=? str "") (values (trim-leading-zeros num) "")]
        [(char-numeric? (string-ref str 0))
         (loop (substring str 1) (string-append num (string (string-ref str 0))))]
        [else (values (trim-leading-zeros num) str)])))

  (define (trim-leading-zeros str)
    (let loop ([str str])
      (cond
        [(string=? str "") "0"]
        [(and (> (string-length str) 1) (char=? (string-ref str 0) #\0)) (loop (substring str 1))]
        [else str])))

  (length (remove-duplicates (extract-integers s) string=?)))