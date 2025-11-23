#lang racket
(require racket/list)

(define (greater? l1 l2)
  (cond
    [(null? l2) #t]
    [(null? l1) #f]
    [(> (car l1) (car l2)) #t]
    [(< (car l1) (car l2)) #f]
    [else (greater? (cdr l1) (cdr l2))]))

(define (find-max-subsequence nums k)
  (if (<= k 0) '()
      (let* ((n (length nums)))
        (let loop ((current-nums nums) (stack '()))
          (cond
            [(null? current-nums)
             (take (reverse stack) k)]
            [else
             (let ((d (car current-nums)))
               (let pop-loop ((s stack) (remaining-digits (cdr current-nums)))
                 (cond
                   [(and (not (null? s))
                         (< (car s) d)
                         (>= (+ (length s) (length remaining-digits)) k))
                    (pop-loop (cdr s) remaining-digits)]
                   [else
                    (loop remaining-digits (cons d s))])))]))))

(define (merge-two-arrays arr1 arr2)
  (let loop ((a1 arr1) (a2 arr2) (result '()))
    (cond
      [(null? a1) (reverse (append a2 result))]
      [(null? a2) (reverse (append a1 result))]
      [(greater? a1 a2)
       (loop (cdr a1) a2 (cons (car a1) result))]
      [else
       (loop a1 (cdr a2) (cons (car a2) result))])))

(define (max-number nums1 nums2 k)
  (let* ((n1 (length nums1))
         (n2 (length nums2))
         (max-res '())
         (start-i (max 0 (- k n2)))
         (end-i (min k n1)))

    (for ((i (range start-i (add1 end-i))))
      (let* ((j (- k i)))
        (let* ((sub1 (find-max-subsequence nums1 i))
               (sub2 (find-max-subsequence nums2 j))
               (merged (merge-two-arrays sub1 sub2)))
          (when (or (null? max-res) (greater? merged max-res))
            (set! max-res merged)))))
    max-res))