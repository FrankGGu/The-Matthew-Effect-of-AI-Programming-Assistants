(define (two-sum nums target)
  (let loop ([seen (hash)] [i 0])
    (cond
      [(>= i (length nums)) #f]
      [(hash-has-key? seen (- target (list-ref nums i)))
       (list (hash-ref seen (- target (list-ref nums i))) i)]
      [else (begin (hash-set! seen (list-ref nums i) i)
                   (loop seen (+ i 1)))])))