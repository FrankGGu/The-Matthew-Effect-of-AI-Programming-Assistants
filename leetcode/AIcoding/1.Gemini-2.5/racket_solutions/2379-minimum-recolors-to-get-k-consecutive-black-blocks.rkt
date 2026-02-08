(define (minimum-recolors blocks k)
  (let* ([n (string-length blocks)]
         [min-w k]) ; Initialize with k, as k is the maximum possible 'W's in a window of size k
    (for ([i (in-range 0 (- n k -1))])
      (let ([current-w 0])
        (for ([j (in-range i (+ i k))])
          (when (char=? (string-ref blocks j) #\W)
            (set! current-w (add1 current-w))))
        (set! min-w (min min-w current-w))))
    min-w))