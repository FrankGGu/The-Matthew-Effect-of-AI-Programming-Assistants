(define (rotate matrix)
  (define n (vector-length matrix))

  (when (> n 0)
    (for ([i (in-range (quotient n 2))])
      (for ([j (in-range i (- n 1 i))])
        (let* ([temp (vector-ref (vector-ref matrix i) j)]

               ;; Coordinates for the four elements in the cycle
               ;; (i, j) -> (j, n-1-i) -> (n-1-i, n-1-j) -> (n-1-j, i) -> (i, j)

               ;; top-right: (j, n-1-i)
               [tr-row j]
               [tr-col (- n 1 i)]

               ;; bottom-right: (n-1-i, n-1-j)
               [br-row (- n 1 i)]
               [br-col (- n 1 j)]

               ;; bottom-left: (n-1-j, i)
               [bl-row (- n 1 j)]
               [bl-col i])

          ;; Perform the 4-way swap
          ;; 1. Move bottom-left to top-left
          (vector-set! (vector-ref matrix i) j
                       (vector-ref (vector-ref matrix bl-row) bl-col))

          ;; 2. Move bottom-right to bottom-left
          (vector-set! (vector-ref matrix bl-row) bl-col
                       (vector-ref (vector-ref matrix br-row) br-col))

          ;; 3. Move top-right to bottom-right
          (vector-set! (vector-ref matrix br-row) br-col
                       (vector-ref (vector-ref matrix tr-row) tr-col))

          ;; 4. Move original top-left (stored in temp) to top-right
          (vector-set! (vector-ref matrix tr-row) tr-col
                       temp))))
  matrix)