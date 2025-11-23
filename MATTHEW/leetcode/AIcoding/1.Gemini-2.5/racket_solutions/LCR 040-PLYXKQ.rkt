#lang racket

(define (maximalRectangle matrix)
  (define rows (length matrix))
  (when (zero? rows) (error "empty matrix")) ; Handle empty matrix
  (define cols (length (car matrix)))
  (when (zero? cols) (error "empty matrix")) ; Handle empty row

  ; Convert matrix to vector of vectors for O(1) access
  (define matrix-vec
    (build-vector rows
                  (lambda (r)
                    (list->vector (list-ref matrix r)))))

  (define current-heights (make-vector cols 0))
  (define max-area 0)

  (define (largestRectangleArea heights)
    (define n (vector-length heights))
    (define stack '()) ; Stores indices
    (define current-max-area 0)

    (for ([i (in-range (+ n 1))]) ; Iterate up to n (inclusive) to handle all elements
      (define h (if (= i n) 0 (vector-ref heights i))) ; Use 0 for the "sentinel" element

      (let loop ()
        (when (and (not (empty? stack))
                   (> (vector-ref heights (car stack)) h))
          (define h-idx (car stack))
          (set! stack (cdr stack))
          (define h-val (vector-ref heights h-idx))
          (define left-boundary-idx (if (empty? stack) -1 (car stack)))
          (define width (- i left-boundary-idx 1))
          (set! current-max-area (max current-max-area (* h-val width)))
          (loop))) ; Continue popping if condition still holds
      (set! stack (cons i stack)))
    current-max-area)

  (for ([row-idx (in-range rows)])
    (define current-row-vec (vector-ref matrix-vec row-idx))
    (for ([col-idx (in-range cols)])
      (if (char=? (vector-ref current-row-vec col-idx) #\1)
          (vector-set! current-heights col-idx (+ (vector-ref current-heights col-idx) 1))
          (vector-set! current-heights col-idx 0)))
    (set! max-area (max max-area (largestRectangleArea current-heights))))

  max-area)