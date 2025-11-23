(define (max-alternating-sum nums)
  (let loop ([nums nums] [even 0] [odd 0])
    (cond
      [(null? nums) (max even odd)]
      [else
       (let ([first (car nums)] [rest (cdr nums)])
         (loop rest (max even (- odd first)) (max odd (+ even first))))])))