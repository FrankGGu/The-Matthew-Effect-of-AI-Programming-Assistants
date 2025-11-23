#lang racket

(define (maxNumberOfGroups nums)
  (define freq (make-hash))
  (for-each (lambda (n) (hash-update! freq n add1)) nums)
  (define sorted (sort (hash-keys freq) >))
  (define (helper i count)
    (if (>= i (length sorted)) count
        (let* ((num (list-ref sorted i))
               (cnt (hash-ref freq num)))
          (if (<= cnt 0)
              (helper (+ i 1) count)
              (let ((new-cnt (- cnt 1)))
                (if (and (< i (- (length sorted) 1)) (= (list-ref sorted (+ i 1)) (- num 1)))
                    (helper (+ i 2) (+ count 1))
                    (helper (+ i 1) (+ count 1)))))))
  )
  (helper 0 0))