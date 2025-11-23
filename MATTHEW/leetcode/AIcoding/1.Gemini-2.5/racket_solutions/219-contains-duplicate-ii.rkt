(define (contains-nearby-duplicate nums k)
  (let ([num-indices (make-hash)])
    (let loop ([idx 0] [remaining-nums nums])
      (cond
        [(empty? remaining-nums) #f]
        [else
         (let* ([current-num (car remaining-nums)]
                [prev-idx (hash-ref num-indices current-num #f)])
           (if prev-idx
               (if (<= (- idx prev-idx) k)
                   #t
                   (begin
                     (hash-set! num-indices current-num idx)
                     (loop (+ idx 1) (cdr remaining-nums))))
               (begin
                 (hash-set! num-indices current-num idx)
                 (loop (+ idx 1) (cdr remaining-nums)))))]))))