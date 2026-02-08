(define (largest-rectangle-in-histogram heights)
  (let* ([n (length heights)]
         [heights-vec (list->vector heights)]
         [extended-heights-vec (vector-append heights-vec (vector 0))])

    (define (stack-empty? s) (null? s))
    (define (stack-push s val) (cons val s))
    (define (stack-peek s) (car s))
    (define (stack-pop s) (cdr s))

    (define-values (final-max-area final-stack)
      (for/fold ([max-area 0] [stack '()])
                ([i (in-range (+ n 1))])
        (let loop ([current-max-area max-area]
                   [current-stack stack])
          (define h_i (vector-ref extended-heights-vec i))

          (if (and (not (stack-empty? current-stack))
                   (>= (vector-ref extended-heights-vec (stack-peek current-stack)) h_i))
              (let* ([h_idx (stack-peek current-stack)]
                     [popped-stack (stack-pop current-stack)]
                     [current-h (vector-ref extended-heights-vec h_idx)]
                     [width (if (stack-empty? popped-stack)
                                i
                                (- i (stack-peek popped-stack) 1))]
                     [new-max-area (max current-max-area (* current-h width))])
                (loop new-max-area popped-stack))
              (values current-max-area (stack-push current-stack i))))))
    final-max-area))