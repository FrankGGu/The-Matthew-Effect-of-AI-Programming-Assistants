(define (canStamp grid stamp)
  (define n (length grid))
  (define m (length (car grid)))
  (define stamp-height (length stamp))
  (define stamp-width (length (car stamp)))

  (define (can-place? r c)
    (for/fold ([result #t]) ([i (in-range stamp-height)] 
                               [j (in-range stamp-width)])
      (if (and (< (+ r i) n) (< (+ c j) m))
          (if (equal? (list-ref (list-ref grid (+ r i)) (+ c j)) 1)
              #t
              (and result (equal? (list-ref (list-ref stamp i) j) 1)))
          result)))

  (define (place-stamp! r c)
    (for ([i (in-range stamp-height)]
          [j (in-range stamp-width)])
      (when (< (+ r i) n)
        (set! (list-ref (list-ref grid (+ r i)) (+ c j)) 1))))

  (define (stamping)
    (for ([r (in-range (- n stamp-height -1))]
          [c (in-range (- m stamp-width -1))])
      (when (can-place? r c)
        (place-stamp! r c))))

  (stamping)
  grid)

(define (gridStamping grid stamp)
  (canStamp grid stamp))

(gridStamping '((0 0 0) (0 0 0) (0 0 0)) '((1 1) (1 1)))