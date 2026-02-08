(define (jump nums)
  (define n (length nums))
  (define (helper i jumps)
    (if (>= i n)
        jumps
        (let loop ((jumps jumps) (pos 0) (max-reach 0) (steps 0))
          (if (>= pos (length nums))
              jumps
              (if (= pos jumps)
                  (loop (add1 jumps) (add1 pos) (max max-reach (+ pos (list-ref nums pos))) steps)
                  (if (> steps max-reach)
                      (loop jumps (add1 pos) max-reach (add1 steps))
                      (loop jumps pos max-reach (add1 steps)))))))
  (helper 0 0))