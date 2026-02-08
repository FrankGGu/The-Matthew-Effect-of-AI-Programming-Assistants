(define (maximal-rectangle matrix)
  (define (max-histogram-area heights)
    (define stack '())
    (define max-area 0)
    (for ([i (in-range (+ 1 (length heights)))])
      (define h (if (< i (length heights)) (list-ref heights i) 0))
      (begin
        (while (and (not (null? stack)) (> (car (reverse stack)) h))
          (let ([height (car (reverse stack))])
            (set! stack (cdr (reverse stack)))
            (define width (if (null? stack) i (- i (car (reverse stack)))))
            (set! max-area (max max-area (* height width)))))
        (set! stack (cons h stack))))
    max-area)

  (if (null? matrix) 0
      (let* ([n (length (car matrix))]
             [heights (make-vector n 0)]
             [max-area 0])
        (for ([row (in-list matrix)])
          (for ([j (in-range n)])
            (if (= (list-ref row j) "1")
                (vector-set! heights j (+ (vector-ref heights j) 1))
                (vector-set! heights j 0)))
          (set! max-area (max max-area (max-histogram-area (vector->list heights)))))
        max-area)))

(maximal-rectangle '(("1" "0" "1" "0" "0")
                     ("1" "0" "1" "1" "1")
                     ("1" "1" "1" "1" "1")
                     ("1" "0" "0" "1" "0")))