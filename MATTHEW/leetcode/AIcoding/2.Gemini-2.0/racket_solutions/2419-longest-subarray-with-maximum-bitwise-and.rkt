(define (find-length nums)
  (let* ([max-and (apply max (map (lambda (x) x) nums))]
         [max-len 0]
         [curr-len 0])
    (for ([num nums])
      (if (= num max-and)
          (begin
            (set! curr-len (+ curr-len 1))
            (set! max-len (max max-len curr-len)))
          (set! curr-len 0)))
    max-len))