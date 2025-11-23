(define (original-digits s)
  (let* ([counts (make-hash)]
         [digits (make-vector 10 0)]
         [unique-chars (hash 'z 0 'w 2 'u 4 'x 6 'g 8 'o 1 'h 3 'f 5 's 7 'i 9)]
         [digit-words (vector "zero" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine")])
    (for ([c s])
      (hash-update! counts c add1 0))
    (for ([(c d) unique-chars])
      (let ([cnt (hash-ref counts c 0)])
      (when (> cnt 0)
        (let ([word (vector-ref digit-words d)])
          (for ([wc word])
            (hash-update! counts wc (lambda (v) (- v cnt)) 0))
          (vector-set! digits d cnt))))
    (let ([result ""])
      (for ([i 10])
        (set! result (string-append result (make-string (vector-ref digits i) (+ i (char->integer #\0))))))
      result))