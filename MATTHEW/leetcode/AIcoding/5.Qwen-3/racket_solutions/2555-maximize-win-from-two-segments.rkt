#lang racket

(define (longest-subarray nums k)
  (let loop ([i 0] [j 0] [max-len 0] [count 0])
    (cond [(= j (length nums)) max-len]
          [(<= count k)
           (loop i (add1 j) (max max-len (- j i)) (+ count (if (= (list-ref nums j) 1) 0 1)))]
          [else
           (loop (add1 i) j max-len (- count (if (= (list-ref nums i) 1) 0 1)))])))

(define (maximize-win-from-two-segments nums)
  (let ([n (length nums)])
    (if (<= n 1)
        (min 1 (length nums))
        (let ([res 0])
          (for ([i (in-range n)])
            (let ([left (longest-subarray (take nums i) 1)]
                  [right (longest-subarray (drop nums (add1 i)) 1)])
              (set! res (max res (+ left right)))))
          res))))

(define (main)
  (define input (read))
  (display (maximize-win-from-two-segments input)))