(define (min-cost nums)
  (define n (length nums))
  (define dp (make-vector (+ n 1) 0))
  (define freq (make-hash))

  (for-each (lambda (x)
              (hash-set! freq x (add1 (hash-ref freq x 0))))
            nums)

  (define sorted-keys (sort (hash-map->list freq) (lambda (x y) (< (car x) (car y)))))

  (for ((i (in-range 1 (length sorted-keys))))
    (define key1 (car (list-ref sorted-keys (- i 1))))
    (define count1 (cdr (list-ref sorted-keys (- i 1))))
    (define key2 (car (list-ref sorted-keys i)))
    (define count2 (cdr (list-ref sorted-keys i)))
    (vector-set! dp i (min (vector-ref dp (- i 1))
                            (+ (vector-ref dp (- i 2)) (* key1 count1))
                            (+ (vector-ref dp (- i 2)) (* key2 count2)))))

  (vector-ref dp (length sorted-keys)))

(define (minCost nums)
  (min-cost nums))