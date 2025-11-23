(define (isPrintable targetGrid)
  (define rows (length targetGrid))
  (define cols (length (car targetGrid)))

  (define (find-rect color)
    (let loop ([r 0] [min-row rows] [max-row -1] [c 0] [min-col cols] [max-col -1])
      (cond
        [(>= r rows) (if (= max-row -1) #f (list min-row max-row min-col max-col))]
        [else
         (let loop2 ([c 0])
           (cond
             [(>= c cols) (loop (+ 1 r) min-row max-row 0 min-col max-col)]
             [(= (list-ref (list-ref targetGrid r) c) color)
              (loop r (min min-row r) (max max-row r) c (min min-col c) (max max-col c))]
             [else (loop2 (+ 1 c))]))])))

  (define colors (remove-duplicates (flatten targetGrid)))

  (define rects
    (filter identity (map find-rect colors)))

  (define (overlap? r1 r2)
    (and
     (<= (list-ref r1 0) (list-ref r2 1))
     (<= (list-ref r2 0) (list-ref r1 1))
     (<= (list-ref r1 2) (list-ref r2 3))
     (<= (list-ref r2 2) (list-ref r1 3))))

  (define (can-print color)
    (let* ([rect (find-rect color)]
           [min-row (list-ref rect 0)]
           [max-row (list-ref rect 1)]
           [min-col (list-ref rect 2)]
           [max-col (list-ref rect 3)]
           [overlapping-colors
            (filter
             (lambda (c)
               (and
                (not (= c color))
                (let ([other-rect (find-rect c)])
                  (if other-rect
                      (overlap? rect other-rect)
                      #f))))
             colors)])
      (if (null? overlapping-colors)
          #t
          (let loop ([r min-row])
            (cond
              [(> r max-row) #t]
              [else
               (let loop2 ([c min-col])
                 (cond
                   [(> c max-col) (loop (+ 1 r))]
                   [else
                    (let ([cell-color (list-ref (list-ref targetGrid r) c)])
                      (if (and (member cell-color overlapping-colors)
                               (not (= cell-color color)))
                          #f
                          (loop2 (+ 1 c)))))]))])))))

  (let loop ([remaining-colors colors])
    (cond
      [(null? remaining-colors) #t]
      [else
       (let ([printable-color (findf can-print remaining-colors)])
         (if printable-color
             (loop (remove printable-color remaining-colors))
             #f))])))
)