(define (closest-subsequence-sum nums goal)
  (define (split-array arr)
    (define mid (quotient (length arr) 2))
    (values (take arr mid) (drop arr mid)))

  (define (generate-subsets arr)
    (cond [(null? arr) (list 0)]
          [else (let* ([rest (generate-subsets (cdr arr))]
                       [first (car arr)]
                       [with-first (map (lambda (x) (+ first x)) rest)])
                  (append rest with-first))]))

  (define (find-closest sorted-list target)
    (let loop ([left 0] [right (- (length sorted-list) 1)] [closest (list-ref sorted-list 0)])
      (cond [(>= left right) closest]
            [else
             (let* ([mid (quotient (+ left right) 2)]
                    [mid-val (list-ref sorted-list mid)]
                    [diff-mid (abs (- mid-val target))]
                    [diff-closest (abs (- closest target))])
               (cond [(< diff-mid diff-closest)
                      (set! closest mid-val)]
                     [(= diff-mid diff-closest)
                      (set! closest (min closest mid-val))])

               (if (< mid-val target)
                   (loop (+ mid 1) right closest)
                   (loop left (- mid 1) closest)))])))

  (define (solve nums goal)
    (define-values (left right) (split-array nums))
    (define left-sums (sort (generate-subsets left) <))
    (define right-sums (generate-subsets right))
    (foldl (lambda (right-sum acc)
             (let* ([target (- goal right-sum)]
                    [closest-left (find-closest left-sums target)]
                    [current-sum (+ closest-left right-sum)]
                    [diff-current (abs (- current-sum goal))]
                    [diff-acc (abs (- acc goal))])
               (if (< diff-current diff-acc)
                   current-sum
                   acc)))
           (car left-sums)
           right-sums))

  (abs (- (solve nums goal) goal)))