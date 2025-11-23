#lang racket

(define (shortest-string a b c)
  (define (merge s1 s2)
    (cond [(string-contains? s1 s2) s1]
          [(string-contains? s2 s1) s2]
          [else
           (let loop ([i (min (string-length s1) (string-length s2))])
             (cond [(zero? i) (string-append s1 s2)]
                   [(and (>= (string-length s1) i)
                         (>= (string-length s2) i)
                     (let ([suffix (substring s1 (- (string-length s1) i))]
                           [prefix (substring s2 0 i)])
                       (if (string=? suffix prefix)
                           (string-append s1 (substring s2 i))
                           (loop (sub1 i))))]
                   [else (loop (sub1 i))]))]))

  (define candidates
    (list
     (merge (merge a b) c)
     (merge (merge a c) b)
     (merge (merge b a) c)
     (merge (merge b c) a)
     (merge (merge c a) b)
     (merge (merge c b) a)
     (merge a (merge b c))
     (merge a (merge c b))
     (merge b (merge a c))
     (merge b (merge c a))
     (merge c (merge a b))
     (merge c (merge b a))))

  (car (sort candidates (λ (x y) (or (< (string-length x) (string-length y))
                                    (and (= (string-length x) (string-length y))
                                         (string<? x y)))))))