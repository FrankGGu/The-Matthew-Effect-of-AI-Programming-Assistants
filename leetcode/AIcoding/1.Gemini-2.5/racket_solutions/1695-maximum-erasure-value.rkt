(define (maximum-unique-subarray nums)
  (let* ([n (length nums)]
         [nums-vec (list->vector nums)]
         [left 0]
         [current-sum 0]
         [max-sum 0]
         [seen (make-hash)])

    (for ([right (in-range n)])
      (let ([current-num (vector-ref nums-vec right)])

        (let loop ()
          (when (hash-has-key? seen current-num)
            (let ([left-num (vector-ref nums-vec left)])
              (hash-remove! seen left-num)
              (set! current-sum (- current-sum left-num))
              (set! left (+ left 1))
              (loop))))

        (hash-set! seen current-num #t)
        (set! current-sum (+ current-sum current-num))
        (set! max-sum (max max-sum current-sum))))

    max-sum))