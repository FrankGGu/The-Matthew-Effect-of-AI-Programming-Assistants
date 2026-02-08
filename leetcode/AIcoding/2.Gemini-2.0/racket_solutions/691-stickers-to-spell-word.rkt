(define (minStickers stickers target)
  (define n (string-length target))
  (define dp (make-vector (+ n 1) -1))
  (vector-set! dp 0 0)

  (define (solve idx)
    (cond
      [(>= idx n) 0]
      [(= (vector-ref dp idx) -1)
       (let* ([res #f]
              [c (string-ref target idx)])
         (for ([sticker stickers])
           (let* ([first-occurrence (string-index sticker c)]
                  [new-idx idx])
             (when first-occurrence
               (let ([sticker-counts (make-vector 26 0)])
                 (for ([i (range (string-length sticker))])
                   (vector-set! sticker-counts (- (char->integer (string-ref sticker i)) (char->integer #\a)) (+ 1 (vector-ref sticker-counts (- (char->integer (string-ref sticker i)) (char->integer #\a))))))
                 (let loop ([i idx])
                   (cond
                     [(>= i n) #t]
                     [else
                      (let ([char-code (- (char->integer (string-ref target i)) (char->integer #\a))])
                        (if (> (vector-ref sticker-counts char-code) 0)
                            (begin
                              (vector-set! sticker-counts char-code (- (vector-ref sticker-counts char-code) 1))
                              (loop (+ i 1)))
                            (loop (+ i 1)))))])))

               (let ([next-idx idx])
                 (let ([sticker-counts (make-vector 26 0)])
                   (for ([i (range (string-length sticker))])
                     (vector-set! sticker-counts (- (char->integer (string-ref sticker i)) (char->integer #\a)) (+ 1 (vector-ref sticker-counts (- (char->integer (string-ref sticker i)) (char->integer #\a))))))

                   (let loop ([i idx])
                     (cond
                       [(>= i n) (set! next-idx i)]
                       [else
                        (let ([char-code (- (char->integer (string-ref target i)) (char->integer #\a))])
                          (if (> (vector-ref sticker-counts char-code) 0)
                              (begin
                                (vector-set! sticker-counts char-code (- (vector-ref sticker-counts char-code) 1))
                                (loop (+ i 1)))
                              (set! next-idx i)
                              ))]))))

               (let ([sub-res (solve next-idx)])
                 (when (not (equal? sub-res #f))
                   (set! res (if res (min res (+ 1 sub-res)) (+ 1 sub-res))))))))))
         (vector-set! dp idx res)
         res)]
      [else (vector-ref dp idx)]))

  (let ([result (solve 0)])
    (if result result -1)))