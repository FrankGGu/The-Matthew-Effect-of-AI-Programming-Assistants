#lang racket

(define (top-k-rewards words-abbrs k)
  (define (word->score word abbr)
    (define (match? w a)
      (and (= (string-length w) (string-length a))
           (for/and ([i (in-range (string-length w))])
             (char=? (string-ref w i) (string-ref a i)))))
    (if (match? word abbr)
        (string-length word)
        0))

  (define scores
    (for/list ([w (in-list words-abbrs)])
      (define word (car w))
      (define abbr (cadr w))
      (cons (word->score word abbr) word)))

  (define sorted
    (sort scores (lambda (a b)
                   (or (> (car a) (car b))
                       (and (= (car a) (car b)) (string<? (cdr a) (cdr b))))))
    )

  (take (map cdr sorted) k))