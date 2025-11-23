(define (ways-to-split array)
  (define n (length array))
  (define prefix-sums (make-vector (+ n 1) 0))
  (for/fold ((i 0)) ((x array) (idx (in-range n)))
    (begin
      (vector-set! prefix-sums (+ idx 1) (+ (vector-ref prefix-sums idx) x))
      (+ i 1)))
  (define (get-sum from to)
    (- (vector-ref prefix-sums (+ to 1)) (vector-ref prefix-sums from)))
  (define (count-splits i)
    (let loop ((left (+ i 1)) (right (- n 2)) (count 0))
      (cond
        ((> left right) count)
        (else
         (let ((left-sum (get-sum 0 i))
               (mid-sum (get-sum i left))
               (right-sum (get-sum left n)))
           (cond
             ((and (>= mid-sum left-sum) (>= right-sum mid-sum))
              (+ count (- right left) 1))
             ((< mid-sum left-sum)
              (loop (+ left 1) right count))
             (else
              (loop left (- right 1) count))))))))
  (define MOD 1000000007)
  (let loop ((i 0) (total 0))
    (cond
      ((>= i (- n 2)) (modulo total MOD))
      (else
       (let ((left-sum (get-sum 0 i))
             (remaining-sum (get-sum (+ i 1) n)))
         (if (<= left-sum (/ remaining-sum 2))
             (loop (+ i 1) (+ total (count-splits i)))
             (loop (+ i 1) total)))))))