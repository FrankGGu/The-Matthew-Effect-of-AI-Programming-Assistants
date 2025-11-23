(define (last-stone-weight stones)
  (define (heapify! arr i n)
    (let* ([largest i]
           [l (+ (* 2 i) 1)]
           [r (+ (* 2 i) 2)])
      (when (and (< l n) (> (list-ref arr l) (list-ref arr largest)))
        (set! largest l))
      (when (and (< r n) (> (list-ref arr r) (list-ref arr largest)))
        (set! largest r))
      (when (not (= largest i))
        (let ([temp (list-ref arr i)])
          (list-set! arr i (list-ref arr largest))
          (list-set! arr largest temp)
          (heapify! arr largest n)))))

  (define (build-heap! arr)
    (let ([n (length arr)])
      (for ([i (in-range (floor (/ n 2)) -1 -1)])
        (heapify! arr i n))))

  (define (extract-max! arr)
    (let* ([n (length arr)]
           [max-val (list-ref arr 0)])
      (list-set! arr 0 (list-ref arr (- n 1)))
      (set! arr (drop-right arr 1))
      (when (not (null? arr))
        (heapify! arr 0 (length arr)))
      (values max-val arr)))

  (define (insert! arr val)
    (set! arr (append arr (list val)))
    (build-heap! arr)
    arr)

  (let ([stones (list->vector stones)])
    (build-heap! stones)
    (let loop ([stones (vector->list stones)])
      (cond
        [(null? stones) 0]
        [(null? (cdr stones)) (car stones)]
        [else
         (let-values ([(y stones) (extract-max! stones)])
           (let-values ([(x stones) (extract-max! stones)])
             (if (> y x)
                 (loop (insert! stones (- y x)))
                 (loop stones))))]))))