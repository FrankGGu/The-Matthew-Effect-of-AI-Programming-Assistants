#lang racket

(define (max-unique-splits s)
  (define n (string-length s))

  (define (backtrack start-idx current-set)
    (if (= start-idx n)
        0
        (let loop ([i start-idx] [max-val 0])
          (if (= i n)
              max-val
              (let* ([sub (substring s start-idx (+ i 1))]
                     [current-max max-val])
                (if (set-member? current-set sub)
                    (loop (+ i 1) current-max)
                    (let ([res (+ 1 (backtrack (+ i 1) (set-add current-set sub)))])
                      (loop (+ i 1) (max current-max res)))))))))

  (backtrack 0 (set)))