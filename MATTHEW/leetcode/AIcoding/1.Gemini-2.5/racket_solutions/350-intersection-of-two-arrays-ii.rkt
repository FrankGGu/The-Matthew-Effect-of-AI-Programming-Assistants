#lang racket

(define (intersect nums1 nums2)
  (let ([freq-map (make-hash)])

    (for-each (lambda (num)
                (hash-update! freq-map num add1 0))
              nums1)

    (let loop ([nums2-list nums2]
               [result '()])
      (if (empty? nums2-list)
          (reverse result)
          (let* ([current-num (car nums2-list)]
                 [count (hash-ref freq-map current-num 0)])
            (if (> count 0)
                (begin
                  (hash-set! freq-map current-num (- count 1))
                  (loop (cdr nums2-list) (cons current-num result)))
                (loop (cdr nums2-list) result)))))))