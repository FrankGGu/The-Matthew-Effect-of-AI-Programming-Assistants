(define (min-flips pal)
  (define n (length pal))
  (define (flip-count row)
    (let loop ((i 0) (j (- n 1)) (count 0))
      (cond
        [(>= i j) count]
        [(not (= (list-ref row i) (list-ref row j))) 
         (loop (+ i 1) (- j 1) (+ count 1))]
        [else (loop (+ i 1) (- j 1) count)])))

  (define (is-palindrome grid)
    (for/fold ([flips 0]) ([i (in-range (/ n 2))])
      (+ flips (flip-count (list (list-ref grid i) (list-ref grid (- n i 1))))))
  )

  (define min-flips
    (for/fold ([count 0]) ([row grid])
      (+ count (is-palindrome row)))) 

  min-flips
)

(define (minFlips pal)
  (min-flips pal)
)