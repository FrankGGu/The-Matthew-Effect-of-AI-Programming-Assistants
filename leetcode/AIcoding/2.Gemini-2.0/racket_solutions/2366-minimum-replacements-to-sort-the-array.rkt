(define (minimum-replacements nums)
  (let loop ([i (- (length nums) 2)]
             [last (last nums)]
             [count 0])
    (if (< i 0)
        count
        (let ([curr (list-ref nums i)])
          (if (<= curr last)
              (loop (- i 1) curr count)
              (let ([num-parts (quotient (+ curr last -1) last)])
                (loop (- i 1) (quotient curr num-parts) (+ count (- num-parts 1)))))))))