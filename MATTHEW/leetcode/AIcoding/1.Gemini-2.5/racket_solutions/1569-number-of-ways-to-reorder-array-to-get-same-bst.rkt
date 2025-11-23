#lang racket

(define MOD 1000000007)
(define MAX-N 1001) ; Max length of nums is 1000, so we need combinations up to C(999, k)

(define combinations
  (let* ([table (make-vector MAX-N)])
    (for ([i (in-range MAX-N)])
      (vector-set! table i (make-vector (add1 i)))) ; C(i, j) where j <= i

    (vector-set! (vector-ref table 0) 0 1) ; C(0, 0) = 1

    (for ([i (in-range 1 MAX-N)])
      (vector-set! (vector-ref table i) 0 1) ; C(i, 0) = 1
      (for ([j (in-range 1 i)])
        (vector-set! (vector-ref table i) j
                     (modulo (+ (vector-ref (vector-ref table (sub1 i)) (sub1 j))
                                (vector-ref (vector-ref table (sub1 i)) j))
                             MOD)))
      (vector-set! (vector-ref table i) i 1)) ; C(i, i) = 1
    table))

(define (get-combinations n k)
  (if (or (< k 0) (> k n))
      0
      (vector-ref (vector-ref combinations n) k)))

(define (num-ways-helper nums-list)
  (let ([n (length nums-list)])
    (cond
      [(<= n 1) 1] ; Base case: 0 or 1 element, only 1 way to form the BST
      [else
       (let* ([root (car nums-list)]
              [rest (cdr nums-list)]
              [left-subtree-elements (filter (lambda (x) (< x root)) rest)]
              [right-subtree-elements (filter (lambda (x) (> x root)) rest)]
              [left-count (length left-subtree-elements)]
              [right-count (length right-subtree-elements)])
         (let* ([ways-left (num-ways-helper left-subtree-elements)]
                [ways-right (num-ways-helper right-subtree-elements)]
                [combinations-val (get-combinations (+ left-count right-count) left-count)])
           ;; Total ways = C(left_count + right_count, left_count) * ways_left * ways_right
           (modulo (* (modulo (* ways-left ways-right) MOD) combinations-val) MOD))))]))

(define (num-of-ways nums)
  (let ([total-ways (num-ways-helper nums)])
    ;; Subtract 1 because the original order is one of the valid ways,
    ;; and the problem asks for "reorder array".
    (modulo (sub1 total-ways) MOD)))