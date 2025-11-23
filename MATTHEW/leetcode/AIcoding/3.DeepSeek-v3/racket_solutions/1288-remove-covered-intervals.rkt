(define/contract (remove-covered-intervals intervals)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([sorted-intervals (sort intervals (lambda (a b) (if (= (car a) (car b)) (> (cadr a) (cadr b)) (< (car a) (car b))))]
         [count 0]
         [prev-end -1])
    (for ([interval sorted-intervals])
      (let ([current-end (cadr interval)])
        (when (> current-end prev-end)
          (set! count (add1 count))
          (set! prev-end current-end))))
    count))