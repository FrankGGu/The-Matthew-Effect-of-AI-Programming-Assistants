(define (can-eat candies queries)
  (define (cumulative-sum lst)
    (let loop ((lst lst) (sum 0) (result '()))
      (if (null? lst)
          (reverse result)
          (loop (cdr lst) (+ sum (car lst)) (cons sum result)))))

  (define candy-sum (cumulative-sum candies))

  (define (can-eat-query query)
    (let* ((favorite-type (car query))
           (favorite-day (cadr query))
           (daily-cap (caddr query))
           (total-candies (list-ref candy-sum favorite-type))
           (total-days (if (= favorite-type 0) 0 (list-ref candy-sum (- favorite-type 1)))))
      (and (>= total-candies (* (+ favorite-day 1) daily-cap))
           (< total-days (* favorite-day daily-cap)))))

  (map can-eat-query queries))