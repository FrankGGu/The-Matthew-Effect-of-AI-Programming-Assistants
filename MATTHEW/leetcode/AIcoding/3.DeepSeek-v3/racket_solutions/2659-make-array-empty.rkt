(define (count-operations-to-empty-array nums)
  (let* ([n (length nums)]
         [sorted (sort (map cons nums (range n)) (lambda (a b) (< (car a) (car b))))]
         [res 0]
         [prev-pos -1])
    (for ([pair sorted])
      (let ([current-pos (cdr pair)])
        (if (> current-pos prev-pos)
            (set! res (+ res (- current-pos prev-pos)))
            (set! res (+ res (- n prev-pos) current-pos)))
        (set! prev-pos current-pos)))
    res))