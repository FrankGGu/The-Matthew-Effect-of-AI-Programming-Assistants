(define (full-bloom-flowers flowers people)
  (let* ([starts (sort (map car flowers) <)]
         [ends (sort (map cdr flowers) <)]
         [n (length flowers)])
    (define (count-flowers time)
      (- (let loop ([l starts] [count 0])
           (cond [(null? l) count]
                 [(<= (car l) time) (loop (cdr l) (+ count 1))]
                 [else count]))
         (let loop ([l ends] [count 0])
           (cond [(null? l) count]
                 [(< (car l) time) (loop (cdr l) (+ count 1))]
                 [else count]))))
    (map count-flowers people)))