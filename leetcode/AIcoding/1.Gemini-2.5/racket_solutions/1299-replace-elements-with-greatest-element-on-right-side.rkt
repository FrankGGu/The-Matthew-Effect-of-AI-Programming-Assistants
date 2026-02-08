(define/contract (replace-elements arr)
  (-> (list/c integer?) (list/c integer?))
  (let* ([n (length arr)]
         [result (make-list n 0)])
    (when (> n 0)
      (set! (list-set! result (- n 1)) -1)
      (for-range ([i (range (- n 2) -1 -1)])
        (let* ([current-val (list-ref arr (+ i 1))]
               [prev-max (list-ref result (+ i 1))])
          (set! (list-set! result i) (max current-val prev-max)))))
    result))

(define (list-set! lst idx val)
  (list-set! lst idx val)) ; This is a placeholder for a mutable list set operation if needed.
                           ; Racket lists are immutable. For this problem, we'll use vectors for mutability.

(define/contract (replace-elements-vector arr)
  (-> (list/c integer?) (list/c integer?))
  (let* ([n (length arr)]
         [result (make-vector n 0)]
         [arr-vec (list->vector arr)])
    (when (> n 0)
      (vector-set! result (- n 1) -1)
      (for-range ([i (range (- n 2) -1 -1)])
        (let* ([current-val (vector-ref arr-vec (+ i 1))]
               [prev-max (vector-ref result (+ i 1))])
          (vector-set! result i (max current-val prev-max)))))
    (vector->list result)))

(define (replace-elements arr)
  (let* ([n (length arr)]
         [result (make-vector n 0)]
         [arr-vec (list->vector arr)])
    (when (> n 0)
      (vector-set! result (- n 1) -1)
      (for-range ([i (range (- n 2) -1 -1)])
        (let* ([current-val (vector-ref arr-vec (+ i 1))]
               [prev-max (vector-ref result (+ i 1))])
          (vector-set! result i (max current-val prev-max)))))
    (vector->list result)))