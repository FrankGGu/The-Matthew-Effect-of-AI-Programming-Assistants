(define (areAlmostEqual s1 s2)
  (let loop ([i 0] [diffs '()])
    (cond
      [(= i (string-length s1))
       (cond
         [(null? diffs) #t]
         [(and (= (length diffs) 2)
               (char=? (string-ref s1 (car diffs)) (string-ref s2 (cadr diffs)))
               (char=? (string-ref s1 (cadr diffs)) (string-ref s2 (car diffs)))) #t]
         [else #f])]
      [(char=? (string-ref s1 i) (string-ref s2 i))
       (loop (+ i 1) diffs)]
      [else
       (loop (+ i 1) (append diffs (list i)))])))