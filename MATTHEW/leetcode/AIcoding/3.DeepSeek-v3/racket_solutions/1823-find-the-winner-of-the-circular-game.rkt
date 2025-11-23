(define (find-the-winner n k)
  (let loop ([lst (build-list n (lambda (x) (+ x 1)))]
             [pos 0])
    (if (= (length lst) 1)
        (car lst)
        (let ([new-pos (modulo (+ pos (- k 1)) (length lst))])
          (loop (append (take lst new-pos) (drop lst (+ new-pos 1)))
                new-pos)))))