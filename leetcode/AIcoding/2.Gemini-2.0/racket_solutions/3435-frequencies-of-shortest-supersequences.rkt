(define (shortest-supersequence-frequencies s words)
  (define n (vector-length s))
  (define m (length words))
  (define word-map (make-hash))
  (for ([i (in-range m)])
    (hash-set! word-map (list-ref words i) i))

  (define (find-shortest-supersequence)
    (define left 0)
    (define right 0)
    (define min-len (add1 n))
    (define freq 0)
    (define word-count (make-vector m 0))
    (define matched 0)
    (define (all-matched?) (= matched m))

    (define (update-count word-index delta)
      (let ([new-count (+ (vector-ref word-count word-index) delta)])
        (vector-set! word-count word-index new-count)
        (cond
          [(and (= delta 1) (= new-count 1)) (set! matched (+ matched 1))]
          [(and (= delta -1) (= new-count 0)) (set! matched (- matched 1))]
          [else #f])))

    (define (process-window)
      (cond
        [(all-matched?)
         (let ([curr-len (- right left)])
           (cond
             [(< curr-len min-len)
              (set! min-len curr-len)
              (set! freq 1)]
             [(= curr-len min-len)
              (set! freq (+ freq 1))]
             [else #f]))
         (let ([left-word (vector-ref s left)])
           (if (hash-has-key? word-map left-word)
               (let ([word-index (hash-ref word-map left-word)])
                 (update-count word-index -1)
                 (set! left (+ left 1))
                 (process-window))
               (begin
                 (set! left (+ left 1))
                 (process-window))))]
        [(< right n)
         (let ([right-word (vector-ref s right)])
           (if (hash-has-key? word-map right-word)
               (let ([word-index (hash-ref word-map right-word)])
                 (update-count word-index 1)
                 (set! right (+ right 1))
                 (process-window))
               (begin
                 (set! right (+ right 1))
                 (process-window))))]
        [else #f]))

    (process-window)
    (if (= min-len (add1 n)) 0 freq))

  (find-shortest-supersequence))