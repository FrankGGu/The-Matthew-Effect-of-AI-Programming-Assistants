#lang racket

(define (minimum-area grid)
  (let* ([R (vector-length grid)]
         [C (vector-length (vector-ref grid 0))]
         [ones (let* ([points '()])
                 (for ([r (in-range R)])
                   (for ([c (in-range C)])
                     (when (= (vector-ref (vector-ref grid r) c) 1)
                       (set! points (cons (cons r c) points)))))
                 points)])

    (define (get-bbox-area points)
      (if (empty? points)
          0
          (let* ([min-r (apply min (map car points))]
                 [max-r (apply max (map car points))]
                 [min-c (apply min (map cdr points))]
                 [max-c (apply max (map cdr points))])
            (* (+ (- max-r min-r) 1)
               (+ (- max-c min-c) 1)))))

    (define (get-bbox-area-for-region all-ones r1 c1 r2 c2)
      (let ([min-r +inf.0] [max-r -inf.0]
            [min-c +inf.0] [max-c -inf.0]
            [found-one #f])
        (for ([p all-ones])
          (let ([r (car p)] [c (cdr p)])
            (when (and (>= r r1) (<= r r2)
                       (>= c c1) (<= c c2))
              (set! found-one #t)
              (set! min-r (min min-r r))
              (set! max-r (max max-r r))
              (set! min-c (min min-c c))
              (set! max-c (max max-c c)))))
        (if found-one
            (* (+ (- max-r min-r) 1)
               (+ (- max-c min-c) 1))
            0)))

    (let ([num-ones (length ones)])
      (cond
        [(= num-ones 0) 0]
        [(<= num-ones 2) (get-bbox-area ones)]
        [else
         (let ([min-total-area +inf.0])

           (when (>= R 3)
             (for ([r-split1 (in-range 0 (- R 2))])
               (for ([r-split2 (in-range (+ r-split1 1) (- R 1))])
                 (set! min-total-area (min min-total-area
                                           (+ (get-bbox-area-for-region ones 0 0 r-split1 (- C 1))
                                              (get-bbox-area-for-region ones (+ r-split1 1) 0 r-split2 (- C 1))
                                              (get-bbox-area-for-region ones (+ r-split2 1) 0 (- R 1) (- C 1))))))))

           (when (>= C 3)
             (for ([c-split1 (in-range 0 (- C 2))])
               (for ([c-split2 (in-range (+ c-split1 1) (- C 1))])
                 (set! min-total-area (min min-total-area
                                           (+ (get-bbox-area-for-region ones 0 0 (- R 1) c-split1)
                                              (get-bbox-area-for-region ones 0 (+ c-split1 1) (- R 1) c-split2)
                                              (get-bbox-area-for-region ones 0 (+ c-split2 1) (- R 1) (- C 1))))))))

           (when (and (>= R 2) (>= C 2))
             (for ([r-split (in-range 0 (- R 1))])
               (for ([c-split (in-range 0 (- C 1))])
                 (set! min-total-area (min min-total-area
                                           (+ (get-bbox-area-for-region ones 0 0 r-split (- C 1))
                                              (get-bbox-area-for-region ones (+ r-split 1) 0 (- R 1) c-split)
                                              (get-bbox-area-for-region ones (+ r-split 1) (+ c-split 1) (- R 1) (- C 1)))))))

             (for ([r-split (in-range 0 (- R 1))])
               (for ([c-split (in-range 0 (- C 1))])
                 (set! min-total-area (min min-total-area
                                           (+ (get-bbox-area-for-region ones (+ r-split 1) 0 (- R 1) (- C 1))
                                              (get-bbox-area-for-region ones 0 0 r-split c-split)
                                              (get-bbox-area-for-region ones 0 (+ c-split 1) r-split (- C 1)))))))

             (for ([c-split (in-range 0 (- C 1))])
               (for ([r-split (in-range 0 (- R 1))])
                 (set! min-total-area (min min-total-area
                                           (+ (get-bbox-area-for-region ones 0 0 (- R 1) c-split)
                                              (get-bbox-area-for-region ones 0 (+ c-split 1) r-split (- C 1))
                                              (get-bbox-area-for-region ones (+ r-split 1) (+ c-split 1) (- R 1) (- C 1)))))))

             (for ([c-split (in-range 0 (- C 1))])
               (for ([r-split (in-range 0 (- R 1))])
                 (set! min-total-area (min min-total-area
                                           (+ (get-bbox-area-for-region ones 0 (+ c-split 1) (- R 1) (- C 1))
                                              (get-bbox-area-for-region ones 0 0 r-split c-split)
                                              (get-bbox-area-for-region ones (+ r-split 1) 0 (- R 1) c-split)))))))

           min-total-area))))