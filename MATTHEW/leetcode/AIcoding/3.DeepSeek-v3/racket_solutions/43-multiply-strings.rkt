(define (multiply num1 num2)
  (let* ([len1 (string-length num1)]
         [len2 (string-length num2)]
         [result (make-list (+ len1 len2) 0)])
    (for ([i (in-range (sub1 len1) -1 -1)])
      (for ([j (in-range (sub1 len2) -1 -1)])
        (let* ([digit1 (- (char->integer (string-ref num1 i)) (char->integer #\0))]
               [digit2 (- (char->integer (string-ref num2 j)) (char->integer #\0))]
               [pos1 (+ i j)]
               [pos2 (+ i j 1)]
               [sum (+ (* digit1 digit2) (list-ref result pos2))])
          (list-set! result pos2 (modulo sum 10))
          (list-set! result pos1 (+ (list-ref result pos1) (quotient sum 10))))
    (let ([s (list->string (map (lambda (x) (integer->char (+ x (char->integer #\0)))) result)])
      (let loop ([i 0])
        (cond
          [(= i (string-length s)) "0"]
          [(char=? (string-ref s i) #\0) (loop (add1 i))]
          [else (substring s i)]))))))