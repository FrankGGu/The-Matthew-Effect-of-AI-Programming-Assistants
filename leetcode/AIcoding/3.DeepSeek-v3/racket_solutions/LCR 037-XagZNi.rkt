(define/contract (asteroid-collision asteroids)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define (collide stack new)
    (cond
      [(empty? stack) (cons new stack)]
      [(let ([top (first stack)])
         (cond
           [(> top 0)
            (if (< new 0)
                (if (> (abs new) top)
                    (collide (rest stack) new)
                    (if (= (abs new) top)
                        (rest stack)
                        stack))
                (cons new stack))]
           [else (cons new stack)]))]))
  (reverse (foldl collide '() asteroids)))