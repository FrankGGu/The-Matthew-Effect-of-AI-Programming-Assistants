(define (min-area-rectangles matrix)
  (define m (length matrix))
  (define n (length (car matrix)))
  (define ones (list))
  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (when (= (list-ref (list-ref matrix i) j) 1)
        (set! ones (cons (list i j) ones)))))
  (if (null? ones)
      0
      (define (solve ones)
        (if (null? ones)
            0
            (define (cover ones rect)
              (define x1 (car (car rect)))
              (define y1 (cadr (car rect)))
              (define x2 (car (cadr rect)))
              (define y2 (cadr (cadr rect)))
              (andmap (lambda (point)
                        (let ([x (car point)]
                              [y (cadr point)])
                          (and (>= x x1) (<= x x2)
                               (>= y y1) (<= y y2))))
                      ones))

        (define (area rect)
          (let ([x1 (car (car rect))]
                [y1 (cadr (car rect))]
                [x2 (car (cadr rect))]
                [y2 (cadr (cadr rect))])
            (* (+ 1 (- x2 x1)) (+ 1 (- y2 y1)))))

        (define (generate-rectangles)
          (letrec ([helper (lambda (rest acc)
                             (cond [(null? rest) acc]
                                   [else (let ([first (car rest)]
                                                 [remaining (cdr rest)])
                                           (append acc
                                                   (map (lambda (second)
                                                          (list first second))
                                                        remaining))
                                           (helper remaining acc))]))])
            (helper ones '())))

        (define valid-rectangles
          (filter (lambda (rect)
                    (cover ones rect))
                  (generate-rectangles)))

        (if (null? valid-rectangles)
            (+ 1e9)
            (apply min (map area valid-rectangles)))))

  (solve ones))