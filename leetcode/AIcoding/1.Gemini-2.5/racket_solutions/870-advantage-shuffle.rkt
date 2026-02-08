(require racket/vector)
(require racket/list)

(define (advantage-shuffle A-list B-list)
  (define n (length A-list))

  ;; Convert input lists to vectors for efficient mutable access
  (define A (list->vector A-list))
  (define B (list->vector B-list))

  ;; 1. Sort A in ascending order
  (define sorted-A (vector-sort < A))

  ;; 2. Create B_indexed = [(B[i], i) for i in range(n)]
  ;;    and sort it by B[i] values in ascending order.
  (define B-indexed-list
    (for/list ([i (in-range n)])
      (cons (vector-ref B i) i)))
  (define sorted-B-indexed
    (vector-sort (lambda (p1 p2) (< (car p1) (car p2)))
                 (list->vector B-indexed-list)))

  ;; 3. Initialize result array (vector)
  (define ans (make-vector n 0))

  ;; 4. Two pointers for sorted-A and two pointers for sorted-B-indexed
  (define a-ptr 0)       ; Pointer for the smallest available element in sorted-A
  (define b-left 0)      ; Pointer for the smallest available element in sorted-B-indexed
  (define b-right (- n 1)) ; Pointer for the largest available element in sorted-B-indexed

  ;; Loop using named let for mutable state
  (let loop ()
    (when (<= b-left b-right) ; Continue as long as there are unassigned B elements
      (define b-val-left (car (vector-ref sorted-B-indexed b-left)))
      (define b-idx-left (cdr (vector-ref sorted-B-indexed b-left)))

      (define current-A-val (vector-ref sorted-A a-ptr))

      (if (> current-A-val b-val-left)
          ;; Case 1: The smallest available A element can beat the smallest available B element.
          ;; This is an optimal match, so we use it.
          (begin
            (vector-set! ans b-idx-left current-A-val)
            (set! a-ptr (+ a-ptr 1))
            (set! b-left (+ b-left 1)))
          ;; Case 2: The smallest available A element cannot beat the smallest available B element.
          ;; In this situation, to maximize advantages, we "waste" the current A element
          ;; by assigning it to the largest available B element. This saves larger A elements
          ;; for smaller B elements that they might actually beat.
          (begin
            (define b-right-idx (cdr (vector-ref sorted-B-indexed b-right)))
            (vector-set! ans b-right-idx current-A-val)
            (set! a-ptr (+ a-ptr 1))
            (set! b-right (- b-right 1))))
      (loop))) ; Continue the loop

  (vector->list ans)) ; Convert the result vector back to a list as expected by LeetCode