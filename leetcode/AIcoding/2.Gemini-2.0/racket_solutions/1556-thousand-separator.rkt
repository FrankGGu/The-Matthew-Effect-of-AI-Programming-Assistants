(define (thousand-separator n)
  (let loop ((n (number->string n)) (acc '()) (count 0))
    (cond
      [(empty? n) (string-join (reverse acc) "")]
      [(= count 3) (loop (substring n 0 (- (string-length n) 1)) (cons "," acc) 1)]
      [else (loop (substring n 0 (- (string-length n) 1)) (cons (substring n (- (string-length n) 1) (string-length n)) acc) (+ count 1))])))