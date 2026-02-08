#lang racket

(require data/heap)

(define (make-array-increasing arr1 arr2)
  (define sorted-arr2 (sort (remove-duplicates arr2) <))
  (define n (length arr1))
  (define m (length sorted-arr2))
  (define dp (make-hash))
  (hash-set! dp -1 0)

  (for ([i (in-range n)])
    (define new-dp (make-hash))
    (for ([(prev-val cnt) (in-hash dp)])
      (when (or (zero? i) (< prev-val (list-ref arr1 i)))
        (define key (list-ref arr1 i))
        (define new-cnt cnt)
        (when (hash-has-key? new-dp key)
          (set! new-cnt (min new-cnt (hash-ref new-dp key))))
        (hash-set! new-dp key new-cnt))
      (define idx (bisect-right sorted-arr2 prev-val))
      (when (< idx m)
        (define key (list-ref sorted-arr2 idx))
        (define new-cnt (add1 cnt))
        (when (hash-has-key? new-dp key)
          (set! new-cnt (min new-cnt (hash-ref new-dp key))))
        (hash-set! new-dp key new-cnt)))
    (set! dp new-dp)
    (when (hash-empty? dp)
      (return -1)))

  (if (hash-empty? dp)
      -1
      (apply min (hash-values dp))))

(define (bisect-right arr target)
  (define (search left right)
    (if (>= left right)
        left
        (let* ([mid (quotient (+ left right) 2)]
               [mid-val (list-ref arr mid)])
          (if (> mid-val target)
              (search left mid)
              (search (add1 mid) right)))))
  (search 0 (length arr)))