(define (validUTF8 bytes)
  (let loop ([bytes bytes] [count 0])
    (cond
      [(empty? bytes) (zero? count)]
      [(= count 0)
       (cond
         [(<= (car bytes) 127) (loop (cdr bytes) 0)]
         [(<= (car bytes) 191) #f]
         [(<= (car bytes) 223) (loop (cdr bytes) 1)]
         [(<= (car bytes) 239) (loop (cdr bytes) 2)]
         [(<= (car bytes) 247) (loop (cdr bytes) 3)]
         [else #f])]
      [else
       (if (and (>= (car bytes) 128) (<= (car bytes) 191))
           (loop (cdr bytes) (- count 1))
           #f)])))