(define (buddy-strings s goal)
  (define (string->list str)
    (string->list str))

  (define (list->string lst)
    (list->string lst))

  (define (solve s goal)
    (cond
      [(not (= (string-length s) (string-length goal))) #f]
      [(= s goal)
       (let ([counts (make-vector 26 0)])
         (for ([c (string->list s)])
           (vector-set! counts (- (char->integer c) (char->integer #\a)) (+ 1 (vector-ref counts (- (char->integer c) (char->integer #\a))))))
         (ormap (lambda (x) (> x 1)) (vector->list counts)))]
      [else
       (let loop ([i 0] [diff '()])
         (cond
           [(= i (string-length s))
            (and (= (length diff) 2)
                 (let ([s-chars (list-ref diff 0)]
                       [g-chars (list-ref diff 1)])
                   (and (= (char-ref s s-chars) (char-ref goal g-chars))
                        (= (char-ref s g-chars) (char-ref goal s-chars)))))]
           [(= (char-ref s i) (char-ref goal i)) (loop (+ i 1) diff)]
           [else (loop (+ i 1) (append diff (list i)))]))]))

  (solve s goal))