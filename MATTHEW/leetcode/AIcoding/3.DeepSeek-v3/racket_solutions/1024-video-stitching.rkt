(define/contract (video-stitching clips time)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (let loop ([clips (sort clips (lambda (a b) (if (= (car a) (car b)) (< (cadr a) (cadr b)) (< (car a) (car b))))]
             [current-end 0]
             [next-end 0]
             [result 0]
             [i 0]
             [n (length clips)])
    (cond
      [(>= current-end time) result]
      [(= i n) -1]
      [else
       (let ([start (car (list-ref clips i))]
             [end (cadr (list-ref clips i))])
         (if (> start current-end)
             (if (<= next-end start) -1 (loop clips next-end next-end (add1 result) i n))
             (loop clips current-end (max next-end end) result (add1 i) n)))])))