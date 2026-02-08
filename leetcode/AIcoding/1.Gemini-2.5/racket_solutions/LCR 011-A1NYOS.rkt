(define (find-max-length nums)
  (let* ([n (length nums)]
         [max-len 0]
         [count 0]
         [count-map (make-hash)])
    (hash-set! count-map 0 -1)

    (for ([i (in-range n)])
      (let ([num (list-ref nums i)])
        (if (= num 0)
            (set! count (- count 1))
            (set! count (+ count 1))))

      (if (hash-has-key? count-map count)
          (set! max-len (max max-len (- i (hash-ref count-map count))))
          (hash-set! count-map count i)))
    max-len))