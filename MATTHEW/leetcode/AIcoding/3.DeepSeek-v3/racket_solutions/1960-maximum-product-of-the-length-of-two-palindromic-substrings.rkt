(define/contract (max-product s)
  (-> string? exact-integer?)
  (define n (string-length s))
  (define (palindrome-lengths s)
    (let* ([n (string-length s)]
           [len (make-vector n 1)]
           [max-right 0]
           [center 0])
      (for ([i (in-range n)])
        (when (< i max-right)
          (vector-set! len i (min (vector-ref len (- (* 2 center) i)) (- max-right i))))
        (let ([left (- i (vector-ref len i))]
              [right (+ i (vector-ref len i))])
          (while (and (>= left 0) (< right n) (char=? (string-ref s left) (string-ref s right)))
            (vector-set! len i (+ (vector-ref len i) 1))
            (set! left (- left 1))
            (set! right (+ right 1)))
        (when (> (+ i (vector-ref len i)) max-right)
          (set! center i))
          (set! max-right (+ i (vector-ref len i)))))
      len))
  (let* ([left-len (palindrome-lengths s)]
         [right-len (palindrome-lengths (list->string (reverse (string->list s))))]
         [right-len (list->vector (reverse (vector->list right-len)))]
         [prefix (make-vector n 1)]
         [suffix (make-vector n 1)])
    (for ([i (in-range 1 n)])
      (vector-set! prefix i (max (vector-ref prefix (- i 1)) (vector-ref left-len (- i 1)))))
    (for ([i (in-range (- n 2) -1 -1)])
      (vector-set! suffix i (max (vector-ref suffix (+ i 1)) (vector-ref right-len (+ i 1)))))
    (let loop ([i 0] [res 0])
      (if (>= i (- n 1))
          res
          (loop (+ i 1) (max res (* (vector-ref prefix i) (vector-ref suffix i))))))))