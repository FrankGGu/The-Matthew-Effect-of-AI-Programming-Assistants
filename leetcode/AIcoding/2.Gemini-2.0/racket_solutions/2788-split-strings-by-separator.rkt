(define (split-string s separator)
  (let loop ([str s] [acc '()])
    (cond
      [(string=? str "") (reverse acc)]
      [(string-contains? str separator)
       (let ([pos (string-index str separator)])
         (loop (substring str (+ pos 1)) (cons (substring str 0 pos) acc)))]
      [else (reverse (cons str acc))])))