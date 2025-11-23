(define (is-self-crossing x)
  (let loop ([i 3] [history (list (list (car x) (cadr x)) (list 0 0))])
    (cond
      [(>= i (length x)) #f]
      [else
       (let* ([d (list-ref x i)]
              [last (car history)]
              [second-last (cadr history)]
              [new-pos (cond
                         [(even? i) (list (car last) (+ (cadr last) d))]
                         [else (list (+ (car last) d) (cadr last))])]
              [new-history (cons new-pos history)])
         (cond
           [(and (> i 3) (>= (car new-pos) (car (list-ref history 2)))
                 (<= (car new-pos) (car second-last))
                 (>= (cadr new-pos) (cadr second-last))
                 (<= (cadr new-pos) (cadr (list-ref history 2)))) #t]
           [(and (> i 4) (>= (car (list-ref history 3)) (car new-pos))
                 (<= (car (list-ref history 3)) (car last))
                 (>= (cadr new-pos) (cadr last))
                 (<= (cadr new-pos) (cadr (list-ref history 3)))) #t]
           [else (loop (+ i 1) new-history)]))]))))