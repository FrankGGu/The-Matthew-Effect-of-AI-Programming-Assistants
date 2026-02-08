#lang racket

(define (create-sorted-array instructions)
  (define max-val 100001) ; Max value of instructions[i] is 10^5, Fenwick tree is 1-indexed
  (define bit (make-vector max-val 0)) ; Fenwick tree array

  ; Update operation for Fenwick tree
  ; Adds 'val' to the element at 'idx' and propagates the change
  (define (update idx val)
    (let loop ((i idx))
      (when (< i max-val)
        (vector-set! bit i (+ (vector-ref bit i) val))
        (loop (+ i (bitwise-and i (- i))))))) ; Move to the next relevant index

  ; Query operation for Fenwick tree (prefix sum)
  ; Returns the sum of elements from index 1 to 'idx'
  (define (query idx)
    (let loop ((i idx) (sum 0))
      (if (zero? i)
          sum
          (loop (bitwise-and i (- i)) (+ sum (vector-ref bit i)))))) ; Move to the parent index

  (define total-cost 0)
  (define current-size 0) ; Number of elements already inserted into the conceptual sorted array

  (for-each (lambda (num)
              ; Count elements strictly less than 'num'
              (define count-less (query (sub1 num)))

              ; Count elements less than or equal to 'num'
              (define count-less-or-equal (query num))

              ; Count elements strictly greater than 'num'
              ; This is total elements so far minus elements <= num
              (define count-greater (- current-size count-less-or-equal))

              ; Add the minimum of these two counts to the total cost
              (set! total-cost (+ total-cost (min count-less count-greater)))

              ; Insert 'num' into the Fenwick tree by incrementing its count
              (update num 1)

              ; Increment the total number of elements inserted
              (set! current-size (add1 current-size)))
            instructions)
  total-cost)