(define (count-bad-pairs nums)
  (define n (length nums))
  (define good-pairs (- (* n (- n 1)) (foldl (lambda (i acc)
                                                 (+ acc (sub1 (index-of nums i))))
                                               0
                                               (range 0 n))))
  (- (* n (- n 1)) good-pairs))

(module leetcode racket
  (require racket/list)
  (provide count-bad-pairs)
  (define (count-bad-pairs nums)
    (define n (length nums))
    (define good-pairs (- (* n (- n 1)) (foldl (lambda (i acc)
                                                   (+ acc (sub1 (index-of nums i))))
                                                 0
                                                 (range 0 n))))
    (- (* n (- n 1)) good-pairs)))