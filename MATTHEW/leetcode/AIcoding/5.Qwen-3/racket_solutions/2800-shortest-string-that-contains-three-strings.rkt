#lang racket

(define (min-superstring a b c)
  (define (merge s1 s2)
    (define (helper s1 s2)
      (if (string-prefix? s2 s1) s1
          (if (string-prefix? s1 s2) s2
              (let loop ([i (min (string-length s1) (string-length s2))])
                (cond [(= i 0) (string-append s1 s2)]
                      [(string-suffix? (substring s1 (- (string-length s1) i)) s2)
                       (string-append s1 (substring s2 i))]
                      [else (loop (- i 1))])))))
    (let ([m1 (helper s1 s2)])
      (let ([m2 (helper s2 s1)])
        (if (< (string-length m1) (string-length m2)) m1 m2))))

  (define (combine s1 s2 s3)
    (let ([m1 (merge s1 s2)])
      (merge m1 s3)))

  (define (all-permutations lst)
    (cond [(null? lst) '(())]
          [else
           (apply append
                  (map (lambda (x)
                         (map (lambda (p) (cons x p))
                              (all-permutations (remove x lst))))
                       lst))]))

  (define (shortest a b c)
    (let ([perms (all-permutations (list a b c))])
      (apply min (map (lambda (p) (combine (car p) (cadr p) (caddr p))) perms))))

  (shortest a b c))