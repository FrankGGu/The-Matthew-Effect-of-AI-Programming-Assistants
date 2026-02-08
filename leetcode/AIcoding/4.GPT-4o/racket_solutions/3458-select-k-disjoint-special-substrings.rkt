#lang racket

(define (max-special-substrings s k)
  (define (is-special? substr)
    (let loop ([i 0] [last #f] [count 0])
      (if (or (>= i (string-length substr)) (>= count 2))
          (if (>= count 2) #f #t)
          (loop (add1 i) (if (char=? (string-ref substr i) last) last (string-ref substr i)) (if (char=? (string-ref substr i) last) count (add1 count))))))

  (define (find-special substr start)
    (if (>= start (string-length s))
        '()
        (let ([next (find-special substr (add1 start))])
          (if (is-special? (substring s start (add1 start)))
              (cons (substring s start (add1 start)) next)
              next))))

  (define special-strings (find-special "" 0))

  (define (count-disjoint special-strings k)
    (if (or (= k 0) (null? special-strings))
        (if (= k 0) 1 0)
        (+ (count-disjoint (cdr special-strings) (sub1 k))
           (count-disjoint (cdr special-strings) k))))

  (count-disjoint special-strings k))

(max-special-substrings "aabbccddeeff" 3)