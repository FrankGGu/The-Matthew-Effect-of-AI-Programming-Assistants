#lang racket

(define (bit-update! bit idx delta)
  (let ([n (- (vector-length bit) 1)])
    (let loop ([i idx])
      (when (<= i n)
        (vector-set! bit i (+ (vector-ref bit i) delta))
        (loop (+ i (bitwise-and i (- i))))))))

(define (bit-query bit idx)
  (let loop ([i idx] [sum 0])
    (if (zero? i)
        sum
        (loop (- i (bitwise-and i (- i))) (+ sum (vector-ref bit i))))))

(define (coordinate-compress nums-list)
  (let* ([all-vals (list->set nums-list)]
         [sorted-unique-vals (sort (set->list all-vals) <)]
         [val->idx (make-hash)])
    (for ([val sorted-unique-vals] [idx (in-naturals 1)])
      (hash-set! val->idx val idx))
    (values val->idx (length sorted-unique-vals))))

(define (distribute-elements nums-list)
  (let* ([n (length nums-list)])
    (if (= n 2)
        nums-list
        (let* ([nums (list->vector nums-list)]
               [first-num (vector-ref nums 0)]
               [second-num (vector-ref nums 1)]
               [arr1-rev (list first-num)]
               [arr2-rev (list second-num)]
               [len1 1]
               [len2 1])

          (let-values (((val->idx max-compressed-idx) (coordinate-compress nums-list)))
            (let ([bit1 (make-vector (+ max-compressed-idx 1) 0)]
                  [bit2 (make-vector (+ max-compressed-idx 1) 0)])

              (bit-update! bit1 (hash-ref val->idx first-num) 1)
              (bit-update! bit2 (hash-ref val->idx second-num) 1)

              (for ([i (in-range 2 n)])
                (let* ([current-num (vector-ref nums i)]
                       [compressed-idx (hash-ref val->idx current-num)]
                       [count1-greater (- (bit-query bit1 max-compressed-idx) (bit-query bit1 compressed-idx))]
                       [count2-greater (- (bit-query bit2 max-compressed-idx) (bit-query bit2 compressed-idx))])

                  (cond
                    ((> count1-greater count2-greater)
                     (set! arr1-rev (cons current-num arr1-rev))
                     (set! len1 (+ len1 1))
                     (bit-update! bit1 compressed-idx 1))
                    ((> count2-greater count1-greater)
                     (set! arr2-rev (cons current-num arr2-rev))
                     (set! len2 (+ len2 1))
                     (bit-update! bit2 compressed-idx 1))
                    (else
                     (if (<= len1 len2)
                         (begin
                           (set! arr1-rev (cons current-num arr1-rev))
                           (set! len1 (+ len1 1))
                           (bit-update! bit1 compressed-idx 1))
                         (begin
                           (set! arr2-rev (cons current-num arr2-rev))
                           (set! len2 (+ len2 1))
                           (bit-update! bit2 compressed-idx 1)))))))

              (append (reverse arr1-rev) (reverse arr2-rev))))))))