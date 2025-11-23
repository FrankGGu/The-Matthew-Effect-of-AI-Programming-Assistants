#lang racket

(define (find-category-recommendation-pairs users)
  (define (parse-user user)
    (map (lambda (s) (string->number s)) (string-split user)))

  (define (get-categories user)
    (define user-ids (parse-user user))
    (if (null? user-ids)
        '()
        (let loop ((i 0) (categories '()))
          (if (= i (length user-ids))
              categories
              (loop (+ i 1) (append categories (list (list (list-ref user-ids i) (list-ref user-ids (+ i 1))))))))))

  (define (combine-pairs pairs)
    (for/fold ([result '()]) ([p pairs])
      (let ([u1 (car p)] [u2 (cadr p)])
        (if (and (not (equal? u1 u2)) (not (member (list u2 u1) result)))
            (cons (list u1 u2) result)
            result))))

  (define all-pairs
    (for/fold ([result '()]) ([user users])
      (append result (get-categories user))))

  (combine-pairs all-pairs))