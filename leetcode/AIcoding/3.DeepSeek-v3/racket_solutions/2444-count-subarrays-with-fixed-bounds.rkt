(define (count-subarrays nums minK maxK)
  (let loop ([i 0] [min-pos -1] [max-pos -1] [left-bound -1] [res 0])
    (if (>= i (length nums))
        res
        (let ([num (list-ref nums i)])
          (cond
            [(or (< num minK) (> num maxK))
             (loop (+ i 1) -1 -1 (+ i 1) res)]
            [else
             (let* ([new-min-pos (if (= num minK) i min-pos)]
                    [new-max-pos (if (= num maxK) i max-pos)]
                    [new-res (if (and (>= new-min-pos 0) (>= new-max-pos 0))
                              (+ res (- (min new-min-pos new-max-pos) left-bound))
                              res)])
               (loop (+ i 1) new-min-pos new-max-pos left-bound new-res)])))))