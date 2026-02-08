(define (rectangle-area-ii rects)
  (define MOD 1000000007)
  (define events '())
  (for ([rect rects])
    (let ([x1 (car rect)]
          [y1 (cadr rect)]
          [x2 (caddr rect)]
          [y2 (cadddr rect)])
      (set! events (append events (list (list x1 y1 y2 1) (list x2 y1 y2 -1))))))
  (set! events (sort events < #:key car))

  (define (update tree start end val left right)
    (cond
      [(or (> left end) (< right start)) tree]
      [(= left start) (= right end) (+ val (or tree 0))]
      [(and (= left start) (= right end)) (+ val (or tree 0))]
      [else
       (let ([mid (quotient (+ start end) 2)])
         (let ([left-tree (update (if (pair? tree) (car tree) #f) start mid val left right)]
               [right-tree (update (if (pair? tree) (cadr tree) #f) (+ mid 1) end val left right)])
           (cons left-tree right-tree)))]))

  (define (query tree start end)
    (cond
      [(not tree) 0]
      [(number? tree) (if (> tree 0) (- end start -1) 0)]
      [else
       (let ([mid (quotient (+ start end) 2)])
         (+ (query (car tree) start mid) (query (cadr tree) (+ mid 1) end)))]))

  (define y-coords (remove-duplicates (flatten (map (lambda (rect) (list (cadr rect) (cadddr rect))) rects))))
  (set! y-coords (sort y-coords <))
  (define y-map (make-hash))
  (for ([i (in-range (length y-coords))])
    (hash-set! y-map (list-ref y-coords i) i))

  (define area 0)
  (define last-x 0)
  (define tree #f)
  (for ([event events])
    (let ([x (car event)]
          [y1 (cadr event)]
          [y2 (caddr event)]
          [type (cadddr event)])
      (if (> area 0)
          (set! area (modulo (+ area (* (- x last-x) (query tree 0 (- (length y-coords) 1)))) MOD)))
      (set! tree (update tree 0 (- (length y-coords) 1) type (hash-ref y-map y1) (- (hash-ref y-map y2) 1)))
      (set! last-x x)))

  area)