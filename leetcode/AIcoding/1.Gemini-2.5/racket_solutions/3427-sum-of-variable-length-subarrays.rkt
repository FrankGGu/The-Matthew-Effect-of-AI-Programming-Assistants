(define (sum-odd-length-subarrays arr)
  (let ([n (length arr)])
    (for/sum ([x arr]
              [i (in-naturals)])
      (let* ([left-choices (+ i 1)]
             [right-choices (- n i)]
             [num-left-odd (quotient left-choices 2)]
             [num-left-even (- left-choices num-left-odd)]
             [num-right-odd (quotient right-choices 2)]
             [num-right-even (- right-choices num-right-odd)])
        (* x (+ (* num-left-even num-right-even)
                (* num-left-odd num-right-odd)))))))