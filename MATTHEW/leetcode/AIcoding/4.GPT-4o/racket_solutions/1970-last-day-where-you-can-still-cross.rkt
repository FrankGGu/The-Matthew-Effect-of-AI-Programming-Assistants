(define (can-cross mid stones)
  (define (helper pos last)
    (cond
      [(= pos (length stones)) #t]
      [(or (< pos 0) (>= pos (length stones))) #f]
      [else
       (for/fold ([result #f]) ([i (max 0 (- last 1)) (min (length stones) (+ last 1 (length stones)))])
         (if (and (not result)
                  (= (list-ref stones pos) (+ (list-ref stones i) mid)))
             (helper i last)
             result))]))
  (helper 0 0))

(define (can-cross-mid stones mid)
  (let ([n (length stones)])
    (if (or (= n 0) (> mid (last stones)))
        #f
        (can-cross mid stones))))

(define (last-day-cross stones)
  (define (binary-search low high)
    (if (= low high)
        low
        (let* ([mid (quotient (+ low high) 2)]
               [can-cross? (can-cross-mid stones mid)])
          (if can-cross?
              (binary-search mid high)
              (binary-search low (- mid 1))))))
  (binary-search 1 (last stones)))

(define (lastDayToCross stones)
  (last-day-cross stones))