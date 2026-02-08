#lang racket

(define (find-the-integer-added-to-array-ii nums1 nums2)
  (define n (length nums1))
  (define s1 (sort nums1 <))
  (define s2 (sort nums2 <))
  (define n-minus-2 (length s2))

  (define (check x)
    (let loop ((p1 0)
               (p2 0)
               (removed-count 0))
      (cond
        ((= p2 n-minus-2)
         (= (+ removed-count (- n p1)) 2))
        ((= p1 n)
         #f)
        ((= (+ (list-ref s1 p1) x) (list-ref s2 p2))
         (loop (+ p1 1) (+ p2 1) removed-count))
        ((< (+ (list-ref s1 p1) x) (list-ref s2 p2))
         (loop (+ p1 1) p2 (+ removed-count 1)))
        (else
         #f))))

  (define x-candidates (list))

  (for ((k (in-range (min n 3))))
    (set! x-candidates (cons (- (list-ref s2 0) (list-ref s1 k)) x-candidates)))

  (for ((k (in-range (min n 3))))
    (set! x-candidates (cons (- (list-ref s2 (- n-minus-2 1)) (list-ref s1 (- n 1 k))) x-candidates)))

  (set! x-candidates (sort (remove-duplicates x-candidates) <))

  (define current-min-x +inf.0)

  (for ((x x-candidates))
    (when (check x)
      (set! current-min-x (min current-min-x x))))

  current-min-x)