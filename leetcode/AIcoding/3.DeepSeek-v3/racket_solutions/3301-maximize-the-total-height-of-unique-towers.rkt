(define/contract (maximize-towers towers)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let loop ([towers (sort towers (lambda (a b) (if (= (car a) (car b)) (< (cadr a) (cadr b)) (< (car a) (car b)))))]
             [prev -inf.0]
             [res 0])
    (if (null? towers)
        res
        (let* ([tower (car towers)]
               [width (car tower)]
               [height (cadr tower)])
          (if (> width prev)
              (loop (cdr towers) width (+ res height))
              (loop (cdr towers) prev res))))))