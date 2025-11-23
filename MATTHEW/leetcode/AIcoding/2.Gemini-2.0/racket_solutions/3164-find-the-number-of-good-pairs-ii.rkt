(define (good-pairs nums)
  (define (count-pairs lst k)
    (let loop ([lst lst] [count 0] [freq (hash)])
      (cond
        [(null? lst) count]
        [else
         (let* ([x (car lst)]
                [diff (- k x)]
                [new-count (+ count (hash-ref freq diff 0))])
           (hash-update! freq x (lambda (v) (+ v 1)) 0)
           (loop (cdr lst) new-count freq))])))
  (count-pairs nums 0))