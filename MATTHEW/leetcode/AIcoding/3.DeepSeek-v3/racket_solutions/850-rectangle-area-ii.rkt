(define/contract (rectangle-area rectangles)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define events '())
  (for ([rect (in-list rectangles)])
    (define x1 (first rect))
    (define y1 (second rect))
    (define x2 (third rect))
    (define y2 (fourth rect))
    (set! events (cons (list y1 'open x1 x2) events))
    (set! events (cons (list y2 'close x1 x2) events)))
  (set! events (sort events (lambda (a b) (< (first a) (first b))))
  (define active '())
  (define result 0)
  (define prev-y (first (first events)))
  (for ([event (in-list events)])
    (define y (first event))
    (define type (second event))
    (define x1 (third event))
    (define x2 (fourth event))
    (when (not (= y prev-y))
      (set! result (+ result (* (- y prev-y) (query active)))))
    (set! prev-y y)
    (if (eq? type 'open)
        (set! active (insert active x1 x2))
        (set! active (remove active x1 x2))))
  (modulo result (expt 10 9 7)))

(define (query active)
  (define total 0)
  (define prev -inf.0)
  (for ([interval (in-list active)])
    (define cur-start (first interval))
    (define cur-end (second interval))
    (set! prev (max prev cur-start))
    (set! total (+ total (max 0 (- cur-end prev))))
    (set! prev (max prev cur-end)))
  total)

(define (insert active x1 x2)
  (define new-active '())
  (define inserted #f)
  (let loop ([active active])
    (cond
      [(empty? active)
       (if inserted
           (reverse new-active)
           (reverse (cons (list x1 x2) new-active)))]
      [else
       (define interval (first active))
       (define cur-start (first interval))
       (define cur-end (second interval))
       (cond
         [(< x2 cur-start)
          (if inserted
              (loop (rest active))
              (begin
                (set! new-active (cons (list x1 x2) new-active))
                (set! inserted #t)
                (loop active)))]
         [(> x1 cur-end)
          (set! new-active (cons interval new-active))
          (loop (rest active))]
         [else
          (set! x1 (min x1 cur-start))
          (set! x2 (max x2 cur-end))
          (loop (rest active))])]))))

(define (remove active x1 x2)
  (define new-active '())
  (for ([interval (in-list active)])
    (define cur-start (first interval))
    (define cur-end (second interval))
    (cond
      [(>= cur-start x2) (set! new-active (cons interval new-active))]
      [(<= cur-end x1) (set! new-active (cons interval new-active))]
      [else
       (when (< cur-start x1)
         (set! new-active (cons (list cur-start x1) new-active)))
       (when (> cur-end x2)
         (set! new-active (cons (list x2 cur-end) new-active)))]))
  (sort new-active (lambda (a b) (< (first a) (first b)))))