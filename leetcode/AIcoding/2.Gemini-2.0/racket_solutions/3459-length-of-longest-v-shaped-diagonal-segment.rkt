(define (longest-v-shaped-diagonal matrix)
  (define m (length matrix))
  (define n (length (car matrix)))
  (define (get-val i j)
    (if (and (>= i 0) (< i m) (>= j 0) (< j n))
        (list i j)
        #f))
  (define (calculate-length start-i start-j)
    (define (helper i j length direction)
      (cond
        [(not (get-val i j)) length]
        [(equal? direction 'right)
         (let [(next-i (+ i 1))
               (next-j (+ j 1))]
           (if (get-val next-i next-j)
               (helper next-i next-j (+ length 1) 'right)
               (helper i j length 'down)))]
        [(equal? direction 'down)
         (let [(next-i (+ i 1))
               (next-j (- j 1))]
           (if (get-val next-i next-j)
               (helper next-i next-j (+ length 1) 'down)
               length))]
        [else length]))
    (helper start-i start-j 1 'right))
  (let loop ([i 0] [max-length 0])
    (if (= i m)
        max-length
        (let loop2 ([j 0])
          (if (= j n)
              (loop (+ i 1) max-length)
              (loop2 (+ j 1) (max max-length (calculate-length i j))))))))