(define (min-height-shelves books shelfWidth)
  (let* ([n (length books)]
         [books-vec (list->vector books)]
         [dp (make-vector (+ n 1) 0)])

    (for ([i (in-range 1 (+ n 1))])
      (vector-set! dp i +inf.0)

      (let ([current-width 0]
            [max-h 0])
        (for ([j (in-range (- i 1) -1 -1)])
          (let* ([book (vector-ref books-vec j)]
                 [book-w (car book)]
                 [book-h (cadr book)])

            (set! current-width (+ current-width book-w))

            (when (> current-width shelfWidth)
              (break))

            (set! max-h (max max-h book-h))

            (let ([prev-dp-val (vector-ref dp j)]
                  [current-min-for-i (vector-ref dp i)])
              (vector-set! dp i (min current-min-for-i (+ prev-dp-val max-h))))))))

    (vector-ref dp n)))