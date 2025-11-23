#lang racket

(define (car-fleet-ii cars-list)
  (define n (length cars-list))
  (define cars (list->vector cars-list)) ; Convert list of lists to vector of vectors for O(1) access
  (define ans (make-vector n -1.0)) ; Initialize answer array with -1.0 (double)

  (define stack '()) ; Stack will store indices of cars

  ; Iterate through cars from right to left (n-1 down to 0)
  (for i (range (- n 1) -1 -1)
    (define car-i (vector-ref cars i))
    (define p_i (vector-ref car-i 0)) ; Position of car i
    (define s_i (vector-ref car-i 1)) ; Speed of car i

    ; Loop to process the stack for the current car i
    ; This inner loop finds the first car j to the right of i that i collides with.
    (let loop-stack ()
      (if (empty? stack)
          ; If stack is empty, no cars to the right for i to collide with.
          ; ans[i] remains -1.0. Push i onto the stack.
          (set! stack (cons i stack))
          (let* ((j (car stack)) ; Get index of car j (top of stack)
                 (car-j (vector-ref cars j))
                 (p_j (vector-ref car-j 0)) ; Position of car j
                 (s_j (vector-ref car-j 1))) ; Speed of car j

            (if (<= s_i s_j)
                ; Car i is slower or equal speed to car j.
                ; Car i can never catch car j. So j is not a valid collision partner for i.
                ; Also, j cannot be part of a fleet that i would collide with.
                ; Pop j from stack and continue checking with the next car on stack.
                (begin
                  (set! stack (cdr stack))
                  (loop-stack))
                ; Car i is faster than car j (s_i > s_j). A collision is possible.
                (let ((t_ij (/ (- (real->double p_j) (real->double p_i))
                               (- (real->double s_i) (real->double s_j)))))
                  (let ((ans_j (vector-ref ans j)))
                    (if (or (= ans_j -1.0) (<= t_ij ans_j))
                        ; Car j either never collides (ans_j is -1.0) OR
                        ; Car i collides with j at or before j collides with the car to its right (t_ij <= ans_j).
                        ; In both cases, j is the car i collides with.
                        (begin
                          (vector-set! ans i t_ij) ; Record collision time for i
                          (set! stack (cons i stack))) ; Push i onto stack. Found collision for i, stop inner loop.
                        ; Car i would collide with j at t_ij, but j itself collides with a car k to its right at ans_j.
                        ; Since t_ij > ans_j, j will have already formed a fleet with k (moving at speed s_k)
                        ; *before* i reaches j. So j is effectively gone as an individual car.
                        ; Pop j and continue checking with the next car on stack (which would be k or the fleet j-k).
                        (begin
                          (set! stack (cdr stack))
                          (loop-stack))))))))))
  ans)