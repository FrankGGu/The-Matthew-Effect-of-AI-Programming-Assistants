(define (find-original-array-of-prefix-xor pref)
  (cond
    [(empty? pref) '()]
    [else
     (let loop ([current-pref (cdr pref)]
                [prev-pref (car pref)]
                [acc (list (car pref))])
       (if (empty? current-pref)
           (reverse acc)
           (let ([head-current (car current-pref)])
             (loop (cdr current-pref)
                   head-current
                   (cons (bitwise-xor head-current prev-pref) acc)))))]))