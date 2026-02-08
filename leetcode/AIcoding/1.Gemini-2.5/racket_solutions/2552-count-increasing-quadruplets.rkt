#lang racket

(struct bit (size arr) #:transparent)

(define (make-bit size)
  (bit size (build-vector (+ size 1) (lambda (i) 0))))

(define (bit-update! b index delta)
  (let* ([arr (bit-arr b)]
         [size (bit-size b)])
    (let loop ([idx index])
      (when (<= idx size)
        (vector-set! arr idx (+ (vector-ref arr idx) delta))
        (loop (+ idx (bitwise-and idx (- idx))))))))

(define (bit-query b index)
  (let* ([arr (bit-arr b)])
    (let loop ([idx index] [sum 0])
      (if (> idx 0)
          (loop (- idx (bitwise-and idx (- idx))) (+ sum (vector-ref arr idx)))
          sum))))

(define (bit-query-suffix b index)
  (let* ([size (bit-size b)])
    (- (bit-query b size) (bit-query b index))))

(define (coordinate-compress nums)
  (let* ([n (vector-length nums)]
         [unique-vals-set (make-hash)]
         [compressed-nums (make-vector n 0)])

    (for ([val (in-vector nums)])
      (hash-set! unique-vals-set val #t))

    (let* ([sorted-unique-vals (sort (hash-keys unique-vals-set) <)]
           [max-rank (length sorted-unique-vals)]
           [val-to-rank (make-hash)])

      (for ([i (in-range max-rank)]
            [val sorted-unique-vals])
        (hash-set! val-to-rank val (+ i 1))) ; 1-indexed ranks

      (for ([i (in-range n)])
        (vector-set! compressed-nums i (hash-ref val-to-rank (vector-ref nums i))))

      (values compressed-nums max-rank))))

(define (count-increasing-quadruplets nums)
  (let* ([n (vector-length nums)])
    (if (< n 4) 0
        (let-values ([(compressed-nums max-rank) (coordinate-compress nums)])
          (let* ([dp-left (build-vector n (lambda (i) (build-vector (+ max-rank 1) (lambda (j) 0))))]
                 [dp-right (build-vector n (lambda (i) (build-vector (+ max-rank 1) (lambda (j) 0))))]
                 [bit-left (make-bit max-rank)]
                 [bit-right (make-bit max-rank)]
                 [total-quadruplets 0])

            ;; Precompute dp-left
            (for ([j (in-range n)])
              (for ([v-rank (in-range 1 (+ max-rank 1))])
                (vector-set! (vector-ref dp-left j) v-rank (bit-query bit-left (- v-rank 1))))
              (bit-update! bit-left (vector-ref compressed-nums j) 1))

            ;; Precompute dp-right
            (for ([k (in-range (- n 1) -1 -1)])
              (for ([v-rank (in-range 1 (+ max-rank 1))])
                (vector-set! (vector-ref dp-right k) v-rank (bit-query-suffix bit-right v-rank)))
              (bit-update! bit-right (vector-ref compressed-nums k) 1))

            ;; Calculate total quadruplets
            (for ([j (in-range 1 (- n 2))]) ; j from 1 to N-3
              (for ([k (in-range (+ j 1) (- n 1))]) ; k from j+1 to N-2
                (when (< (vector-ref nums k) (vector-ref nums j))
                  (let* ([count-i (vector-ref (vector-ref dp-left j) (vector-ref compressed-nums k))]
                         [count-l (vector-ref (vector-ref dp-right k) (vector-ref compressed-nums j))])
                    (set! total-quadruplets (+ total-quadruplets (* count-i count-l)))))))
            total-quadruplets)))))