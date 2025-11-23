(define/contract (maximum-and-minimum-sum nums k)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (define (solve op)
    (let loop ([i 0] [sum 0] [heap (make-heap (if (eq? op <) > <))] [res 0])
      (if (>= i (length nums))
          res
          (let* ([num (list-ref nums i)]
                 [new-sum (+ sum num)]
                 [new-heap (heap-push heap num)])
            (when (>= (heap-count new-heap) k)
              (set! new-sum (- new-sum (heap-pop new-heap)))
            (loop (add1 i) new-sum new-heap (op res new-sum))))))
  (list (solve max) (solve min)))