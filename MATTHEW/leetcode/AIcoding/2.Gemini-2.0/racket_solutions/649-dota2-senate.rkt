(define (predict-party-victory senate)
  (let ([n (string-length senate)]
        [radiant (for/list ([i (in-range n)])
                   (if (char=? (string-ref senate i) #\R) i #f))]
        [dire (for/list ([i (in-range n)])
                (if (char=? (string-ref senate i) #\D) i #f))])
    (let loop ([radiant (filter identity radiant)]
               [dire (filter identity dire)])
      (cond
        [(null? radiant) "Dire"]
        [(null? dire) "Radiant"]
        [else
         (let ([r (first radiant)]
               [d (first dire)])
           (if (< r d)
               (loop (append (rest radiant) (list (+ d n))) (rest dire))
               (loop (rest radiant) (append (rest dire) (list (+ r n))))))])))
  )