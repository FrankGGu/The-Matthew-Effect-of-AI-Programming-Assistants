(define (tiling-rectangle n m)
  (define memo (make-hash))

  (define (solve h w)
    (cond
      [(or (= h 0) (= w 0)) 0]
      [(= h w) 1]
      [(hash-has-key? memo (cons h w)) (hash-ref memo (cons h w))]
      [else
       (define ans
         (let loop ([i 1])
           (cond
             [(> i (min h w)) +inf.0]
             [else
              (min (cond
                     [(= h w) 1]
                     [(>= h w)
                      (+ 1 (min (solve (- h i) w) (solve h (- w i))))]
                     [else
                      (+ 1 (min (solve (- w i) h) (solve w (- h i))))])
                   (loop (+ i 1)))])))
       (hash-set! memo (cons h w) ans)
       (hash-set! memo (cons w h) ans)
       ans]))

  (solve n m))