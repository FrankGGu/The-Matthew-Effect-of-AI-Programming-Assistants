#lang racket

(define (word-subsets words1 words2)
  (define (count-letters s)
    (define (helper s count)
      (if (null? s)
          count
          (let ([c (car s)])
            (helper (cdr s)
                    (hash-update count c add1 0)))))
    (helper (string->list s) (make-hash)))

  (define (merge-max-counts h1 h2)
    (define (helper key count)
      (hash-set h1 key (max (hash-ref h1 key 0) count)))
    (for-each helper (hash-keys h2))
    h1)

  (define max-word2-count (foldl merge-max-counts (make-hash) (map count-letters words2)))

  (define (is-subset? word-count)
    (for/and ([k (in-hash-keys max-word2-count)])
      (>= (hash-ref word-count k 0) (hash-ref max-word2-count k))))

  (filter is-subset? (map count-letters words1))
  (map (lambda (x) (car (filter (lambda (w) (equal? (count-letters w) x)) words1))) (filter is-subset? (map count-letters words1)))
  (filter (lambda (w) (is-subset? (count-letters w))) words1))