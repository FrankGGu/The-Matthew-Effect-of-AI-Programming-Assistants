(define (distinctDifferenceArray nums)
  (define n (length nums))
  (define left-count (make-vector n 0))
  (define right-count (make-vector n 0))

  (define left-set (make-hash))
  (define right-set (make-hash))

  (for ([i n])
    (hash-set! right-set (list-ref nums i) #t))

  (for ([i n])
    (if (hash-ref left-set (list-ref nums i) #f)
        (vector-set! left-count i (hash-count left-set))
        (begin
          (hash-set! left-set (list-ref nums i) #t)
          (vector-set! left-count i (hash-count left-set))))
    (hash-remove! right-set (list-ref nums i)))

  (for ([i (in-range (sub1 n) -1 -1)])
    (vector-set! right-count i (hash-count right-set)))

  (for/list ([i n])
    (- (vector-ref left-count i) (vector-ref right-count i))))

(define (distinctDifferenceArrayWrapper nums)
  (distinctDifferenceArray nums))