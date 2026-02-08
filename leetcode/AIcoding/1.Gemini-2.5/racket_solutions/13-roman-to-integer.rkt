(define (roman-to-int s)
  (define roman-map
    (hash #\I 1 #\V 5 #\X 10 #\L 50 #\C 100 #\D 500 #\M 1000))

  (define (char->val c)
    (hash-ref roman-map c))

  (define (convert-list chars)
    (cond
      [(empty? chars) 0]
      [(empty? (rest chars)) (char->val (first chars))]
      [else
       (let* ([current-char (first chars)]
              [next-char (second chars)]
              [current-val (char->val current-char)]
              [next-val (char->val next-char)])
         (if (< current-val next-val)
             (+ (- next-val current-val) (convert-list (rest (rest chars))))
             (+ current-val (convert-list (rest chars)))))]))

  (convert-list (string->list s)))