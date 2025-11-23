(define (maximize-happiness row col intro extro)
  (define m (length (first row)))
  (define n (length row))

  (define (valid? r c)
    (and (>= r 0) (< r n) (>= c 0) (< c m)))

  (define (calculate-happiness grid r c type)
    (let* ([curr-happiness (if (= type 1) 120 40)]
           [neighbor-happiness
            (let loop ([dr '(-1 1 0 0)]
                       [dc '(0 0 -1 1)]
                       [acc 0])
              (cond
                [(null? dr) acc]
                (else
                 (let ([nr (+ r (car dr))]
                       [nc (+ c (car dc))])
                   (if (and (valid? nr nc) (list? (list-ref grid nr)))
                       (let ([neighbor-type (list-ref grid nr nc)])
                         (loop (cdr dr) (cdr dc) (+ acc (if (= type neighbor-type) -30 20))))
                       (loop (cdr dr) (cdr dc) acc))))))])
      (+ curr-happiness neighbor-happiness)))

  (define (solve r c intro-left extro-left grid)
    (cond
      [(and (= r n) (= intro-left 0) (= extro-left 0)) 0]
      [(and (= r n)) -1000000000] ; Penalize early termination
      [(= c m) (solve (+ r 1) 0 intro-left extro-left grid)]
      [else
       (let ([no-place-happiness (solve r (+ c 1) intro-left extro-left grid)])
         (cond
           [(> intro-left 0)
            (let* ([new-grid (append (take grid r)
                                     (list (append (list-ref grid r) (list 1)))
                                     (drop grid (+ r 1)))]
                   [place-happiness (+ (calculate-happiness new-grid r c 1)
                                       (solve r (+ c 1) (- intro-left 1) extro-left new-grid))])
              (max no-place-happiness place-happiness))]
           [(> extro-left 0)
            (let* ([new-grid (append (take grid r)
                                     (list (append (list-ref grid r) (list 2)))
                                     (drop grid (+ r 1)))]
                   [place-happiness (+ (calculate-happiness new-grid r c 2)
                                       (solve r (+ c 1) intro-left (- extro-left 1) new-grid))])
              (max no-place-happiness place-happiness))]
           [else no-place-happiness]))]))

  (solve 0 0 intro extro (make-list n (make-list m #f))))