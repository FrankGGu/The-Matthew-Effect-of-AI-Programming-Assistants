(define (appeal-sum s)
  (let loop ([i 0] [sum 0] [last-pos (make-hash)] [current 0])
    (if (= i (string-length s))
        sum
        (let* ([c (string-ref s i)]
               [prev (hash-ref last-pos c -1)]
               [diff (- i prev)]
               [new-current (+ current diff)])
          (hash-set! last-pos c i)
          (loop (+ i 1) (+ sum new-current) last-pos new-current)))))