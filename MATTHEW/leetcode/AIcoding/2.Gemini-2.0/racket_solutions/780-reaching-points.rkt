(define (reaching-points sx sy tx ty)
  (cond
    [(and (= sx tx) (= sy ty)) #t]
    [(or (> sx tx) (> sy ty)) #f]
    [(and (= sx tx) (< sy ty)) (if (zero? sx) #f (zero? (modulo (- ty sy) sx)))]
    [(and (< sx tx) (= sy ty)) (if (zero? sy) #f (zero? (modulo (- tx sx) sy)))]
    [else
     (cond
       [(> tx ty)
        (if (zero? ty)
            #f
            (let [(diff (- tx sx))]
              (if (>= diff ty)
                  (let [(rem (modulo diff ty))]
                    (if (>= (+ sx rem) sx)
                        (reaching-points sx sy (+ sx rem) ty)
                        #f))
                  (reaching-points sx sy tx (- tx ty)))))
       (else
        (if (zero? tx)
            #f
            (let [(diff (- ty sy))]
              (if (>= diff tx)
                  (let [(rem (modulo diff tx))]
                    (if (>= (+ sy rem) sy)
                        (reaching-points sx sy tx (+ sy rem))
                        #f))
                  (reaching-points sx sy (- ty tx) ty)))))]]))