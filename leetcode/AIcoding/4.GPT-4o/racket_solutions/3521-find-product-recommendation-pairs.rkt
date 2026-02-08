(define (find-recommendation-pairs products target)
  (define (count-pairs lst)
    (define (helper lst acc)
      (if (null? lst)
          acc
          (let* ((head (car lst))
                 (tail (cdr lst))
                 (matches (filter (lambda (x) (= (+ head x) target)) tail)))
                 (new-acc (append acc (map (lambda (x) (list head x)) matches))))
            (helper tail new-acc))))
    (helper lst '()))
  (count-pairs products))

(find-recommendation-pairs '(1 2 3 4 5) 5)