#lang racket

(define (min-operations nums)
  (define n (length nums))
  (if (= n 1) 0
      (let* ([even-count (make-hash)]
             [odd-count (make-hash)]
             [max-even 0]
             [max-odd 0]
             [second-max-even 0]
             [second-max-odd 0])
        (for ([i (in-range n)])
          (let ([val (list-ref nums i)])
            (if (even? i)
                (begin
                  (hash-set! even-count val (+ 1 (hash-ref even-count val 0)))
                  (when (> (hash-ref even-count val 0) max-even)
                    (set! second-max-even max-even)
                    (set! max-even (hash-ref even-count val 0)))
                  (when (and (< (hash-ref even-count val 0) max-even) (> (hash-ref even-count val 0) second-max-even))
                    (set! second-max-even (hash-ref even-count val 0))))
                (begin
                  (hash-set! odd-count val (+ 1 (hash-ref odd-count val 0)))
                  (when (> (hash-ref odd-count val 0) max-odd)
                    (set! second-max-odd max-odd)
                    (set! max-odd (hash-ref odd-count val 0)))
                  (when (and (< (hash-ref odd-count val 0) max-odd) (> (hash-ref odd-count val 0) second-max-odd))
                    (set! second-max-odd (hash-ref odd-count val 0))))))
        (let ([even-max (if (hash-has-key? even-count (hash-key (hash-ref even-count))) max-even 0)]
              [odd-max (if (hash-has-key? odd-count (hash-key (hash-ref odd-count))) max-odd 0)])
          (if (and (= even-max 0) (= odd-max 0)) 0
              (if (= even-max odd-max)
                  (min (- n max-even) (- n max-odd))
                  (if (> even-max odd-max)
                      (- n even-max)
                      (- n odd-max)))))))