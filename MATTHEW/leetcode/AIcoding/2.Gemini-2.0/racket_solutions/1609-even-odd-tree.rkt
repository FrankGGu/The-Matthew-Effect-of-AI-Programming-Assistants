(define (is-even-odd-tree root)
  (let loop ([q (list root)]
             [level 0])
    (cond
      [(empty? q) #t]
      [else
       (let* ([vals (map (lambda (node) (cond [(null? node) #f] [else (->> node struct-field-values first)])) q)]
              [valid? (andmap (lambda (val) (not (equal? val #f))) vals)]
              [even-level? (even? level)]
              [level-valid?
               (and valid?
                    (andmap (lambda (val) (if even-level? (even? val) (odd? val))) vals)
                    (if (>= (length vals) 2)
                        (let loop2 ([rest vals] [prev (first vals)])
                          (cond
                            [(empty? (rest rest)) #t]
                            [else
                             (let ([curr (first (rest rest))])
                               (if even-level?
                                   (and (< prev curr) (loop2 (rest rest) curr))
                                   (and (> prev curr) (loop2 (rest rest) curr))))]))
                        #t))]
              [next-q (flatten (map (lambda (node) (cond [(null? node) '()] [else (list (->> node struct-field-values second) (->> node struct-field-values third))])) q))])
         (if level-valid?
             (loop next-q (+ level 1))
             #f))])))