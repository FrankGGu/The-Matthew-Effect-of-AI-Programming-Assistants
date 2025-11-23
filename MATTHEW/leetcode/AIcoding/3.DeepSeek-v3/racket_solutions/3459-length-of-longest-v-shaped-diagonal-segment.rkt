#lang racket

(define (longest-v-shaped-segment matrix)
  (define rows (length matrix))
  (if (zero? rows) 0
      (define cols (length (car matrix)))
      (define max-len 0)

      (define (check-diagonal i j)
        (define (helper x y prev dir len)
          (cond [(or (< x 0) (>= x rows) (< y 0) (>= y cols)) len]
                [(let ((curr (list-ref (list-ref matrix x) y)))
                  (cond [(= len 0) (helper (add1 x) (add1 y) curr 0 1)]
                        [(and (= dir 0) (< curr prev)) 
                         (helper (add1 x) (add1 y) curr -1 (add1 len))]
                        [(and (= dir -1) (> curr prev))
                         (helper (add1 x) (add1 y) curr 1 (add1 len))]
                        [(and (= dir 1) (> curr prev))
                         (helper (add1 x) (add1 y) curr 1 (add1 len))]
                        [else len]))]))
        (helper i j -1 0 0))

      (for ([i (in-range rows)])
      (for ([j (in-range cols)])
        (set! max-len (max max-len (check-diagonal i j))))
      max-len))