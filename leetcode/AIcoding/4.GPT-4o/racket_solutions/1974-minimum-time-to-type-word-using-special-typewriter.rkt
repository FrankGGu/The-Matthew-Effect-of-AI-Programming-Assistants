(define (minTimeToType word)
  (define (char-distance a b)
    (min (abs (- (char->integer a) (char->integer b)))
         (abs (- 26 (abs (- (char->integer a) (char->integer b)))))))
  (define total-time (foldl (lambda (c acc)
                               (if (null? acc)
                                   (+ 1 (char->integer c))
                                   (+ 1 (char-distance (car acc) c))))
                             '()
                             (string->list word)))
  total-time)

(minTimeToType "abc")  ; Example usage