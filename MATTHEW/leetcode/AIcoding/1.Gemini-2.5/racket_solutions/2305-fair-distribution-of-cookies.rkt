#lang racket
(require racket/list)

(define (fair-distribution-of-cookies cookies k)
  (define n (length cookies))

  (define sorted-cookies (sort cookies >))

  (define initial-child-sums (make-list k 0))

  (define min-unfairness (make-box +inf.0))

  (define (dfs cookie-idx child-sums)
    (if (>= (apply max child-sums) (unbox min-unfairness))
        (void)
        (if (= cookie-idx n)
            (set-box! min-unfairness (min (unbox min-unfairness) (apply max child-sums)))
            (let ((current-cookie (list-ref sorted-cookies cookie-idx)))
              (for ([i (in-range k)])
                (let ((new-child-sums
                       (list-set child-sums i (+ (list-ref child-sums i) current-cookie))))
                  (dfs (+ cookie-idx 1) new-child-sums)))))))

  (dfs 0 initial-child-sums)
  (unbox min-unfairness))