#lang racket

(require data/heap)

(define (max-subsequence-score nums1 nums2 k)
  (let* ([n (vector-length nums1)]
         [pairs (for/list ([i (in-range n)])
                  (list (vector-ref nums1 i) (vector-ref nums2 i)))]
         [sorted-pairs (sort pairs (lambda (a b) (> (second a) (second b))))])
    (car
     (for/fold ([max-s 0]
                [current-s 0]
                [h (make-heap (lambda (a b) (< a b)))])
               ([pair sorted-pairs])
       (let* ([n1 (first pair)]
              [n2 (second pair)])

         (heap-add! h n1)

         (let ([sum-after-add (+ current-s n1)])

           (if (> (heap-count h) k)
               (let* ([smallest-n1 (heap-min h)]
                      [_ (heap-remove-min! h)]
                      [sum-after-removal (- sum-after-add smallest-n1)])
                 (let ([next-max-s (if (= (heap-count h) k)
                                       (max max-s (* sum-after-removal n2))
                                       max-s)])
                   (values next-max-s sum-after-removal h)))
               (let ([next-max-s (if (= (heap-count h) k)
                                     (max max-s (* sum-after-add n2))
                                     max-s)])
                 (values next-max-s sum-after-add h))))))))