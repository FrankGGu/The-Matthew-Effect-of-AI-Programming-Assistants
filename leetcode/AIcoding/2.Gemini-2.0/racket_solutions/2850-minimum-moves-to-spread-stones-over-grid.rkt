(define (minimum-moves-to-spread-stones-over-grid grid)
  (define n (vector-length grid))
  (define sources '())
  (define sinks '())
  (for/fold (void) ([i (in-range n)])
    (for/fold (void) ([j (in-range n)])
      (cond
        [(> (vector-ref (vector-ref grid i) j) 1)
         (set! sources (append sources (list (list i j (- (vector-ref (vector-ref grid i) j) 1)))))]
        [(< (vector-ref (vector-ref grid i) j) 1)
         (set! sinks (append sinks (list (list i j (- 1 (vector-ref (vector-ref grid i) j)))))]))
      void)
    void)

  (define (manhattan-distance x1 y1 x2 y2)
    (+ (abs (- x1 x2)) (abs (- y1 y2))))

  (define (solve sources sinks moves)
    (cond
      [(null? sources) moves]
      [(null? sinks) moves]
      [else
       (let* ([source (car sources)]
              [sink (car sinks)]
              [source-x (car source)]
              [source-y (cadr source)]
              [source-count (caddr source)]
              [sink-x (car sink)]
              [sink-y (cadr sink)]
              [sink-count (caddr sink)]
              [transfer (min source-count sink-count)]
              [dist (manhattan-distance source-x source-y sink-x sink-y)])
         (cond
           [(= transfer source-count)
            (solve (cdr sources) (cons (list sink-x sink-y (- sink-count transfer)) (cdr sinks)) (+ moves (* transfer dist)))]
           [(= transfer sink-count)
            (solve (cons (list source-x source-y (- source-count transfer)) (cdr sources)) (cdr sinks) (+ moves (* transfer dist)) ]
           [else (error "Invalid state")]))]))

  (solve sources sinks 0))