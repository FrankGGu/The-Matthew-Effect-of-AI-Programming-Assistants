(define (max-depth s)
  (let loop ([chars (string->list s)] [current 0] [max-depth 0])
    (if (null? chars)
        max-depth
        (let ([char (car chars)])
          (cond
            [(char=? char #\() (loop (cdr chars) (+ current 1) (max max-depth (+ current 1)))]
            [(char=? char #\)) (loop (cdr chars) (- current 1) max-depth)]
            [else (loop (cdr chars) current max-depth)])))))