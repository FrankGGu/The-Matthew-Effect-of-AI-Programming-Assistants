(define (relative-sort-array arr1 arr2)
  (let* ([freq (make-hash)]
         [_ (for ([x arr1])
              (hash-update! freq x (λ (v) (+ v 1)) 1))]
         [res '()])
    (for ([x arr2])
      (let ([count (hash-ref freq x 0)])
        (for ([i (range count)])
          (set! res (append res (list x))))
        (hash-remove! freq x)))
    (let* ([remaining (sort (hash-keys freq) <)]
           [remaining-res '()])
      (for ([x remaining])
        (let ([count (hash-ref freq x 0)])
          (for ([i (range count)])
            (set! remaining-res (append remaining-res (list x))))))
      (append res remaining-res))))