(define (pathInZigZagTree n)
  (define (level n)
    (let loop ([i 1] [l 1])
      (if (>= i n)
          l
          (loop (* i 2) (+ l 1)))))

  (define (level-range l)
    (list (expt 2 (- l 1)) (- (expt 2 l) 1)))

  (define (reverse-value l v)
    (let ([range (level-range l)])
      (+ (car range) (- (cadr range) v))))

  (define l (level n))
  (define path '())
  (let loop ([v n] [level l] [is-reversed? (odd? l)])
    (cond
      [(zero? level) path]
      [else
       (let ([current-value (if is-reversed? (reverse-value level v) v)])
         (set! path (cons current-value path))
         (let ([parent-value (floor (/ (if is-reversed? (reverse-value level v) v) 2))])
           (loop parent-value (- level 1) (not is-reversed?)))))]))
  path)