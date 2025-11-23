(define (max-sum-two-no-overlap arr firstLen secondLen)
  (define (max-sum-len arr len)
    (define (iter i sum max-sum)
      (cond
        [(>= i (length arr)) max-sum]
        [else
         (let* ((new-sum (+ sum (list-ref arr i)))
                (old-sum (if (> i len) (- new-sum (list-ref arr (- i len))) 0)))
           (iter (+ i 1) old-sum (max max-sum old-sum)))]))
    (iter 0 0 0))

  (define (max-sum-split arr len1 len2)
    (define (iter i max-so-far)
      (cond
        [(>= i (- (length arr) len1 -1)) max-so-far]
        [else
         (let* ((first-sub (take (drop arr i) len1))
                (second-sub (append (take arr i) (drop (+ i len1) arr)))
                (current-sum (+ (max-sum-len first-sub len1) (max-sum-len second-sub len2))))
           (iter (+ i 1) (max max-so-far current-sum)))]))
    (iter 0 0))

  (max (max-sum-split arr firstLen secondLen)
       (max-sum-split arr secondLen firstLen)))