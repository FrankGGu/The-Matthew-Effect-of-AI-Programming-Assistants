(define (longest-zigzag path)
  (cond
    [(null? path) 0]
    [else
     (let loop ([node path] [left-len 0] [right-len 0] [max-len 0])
       (cond
         [(null? node) max-len]
         [else
          (let ([left-child (car (cdr (car node))))]
                [right-child (car (cdr (cdr (car node))))])
            (let ([new-left-len (if (null? left-child) 0 (+ right-len 1))]
                  [new-right-len (if (null? right-child) 0 (+ left-len 1))]
                  [new-max-len (max max-len new-left-len new-right-len)])
              (loop (cons (list left-child (if (null? left-child) #f #t) (if (null? left-child) #f #t)) (cdr node)) new-left-len 0 new-max-len)
              (loop (cons (list right-child (if (null? right-child) #f #t) (if (null? right-child) #f #t)) (cdr node)) 0 new-right-len new-max-len)
              (max new-max-len (loop (cdr node) 0 0 new-max-len)))))]))]))

(define (longest-zigzag-path root)
  (if (null? root)
      0
      (longest-zigzag (list (list root #f #f)))))