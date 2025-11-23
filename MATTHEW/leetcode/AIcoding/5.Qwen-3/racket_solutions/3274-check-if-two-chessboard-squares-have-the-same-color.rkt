(define (can-attack? a b)
  (let ([x1 (string-ref a 0)]
        [y1 (string-ref a 1)]
        [x2 (string-ref b 0)]
        [y2 (string-ref b 1)])
    (if (char=? x1 x2)
        #f
        (let ([dx (abs (- (char->integer x1) (char->integer x2)))]
              [dy (abs (- (char->integer y1) (char->integer y2)))])
          (= (modulo (+ dx dy) 2) 1)))))