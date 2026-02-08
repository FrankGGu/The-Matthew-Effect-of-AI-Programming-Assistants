(define (maximum-score nums k)
  (define n (length nums))
  (define left (make-vector n))
  (define right (make-vector n))

  (define (find-left-bound)
    (let loop ((i k))
      (if (and (>= i 0) (not (= nums[i] (vector-ref nums k))))
          (begin
            (vector-set! left i k)
            (loop (sub1 i)))
          (vector-set! left k k))))

  (define (find-right-bound)
    (let loop ((i k))
      (if (and (< i n) (not (= nums[i] (vector-ref nums k))))
          (begin
            (vector-set! right i k)
            (loop (add1 i)))
          (vector-set! right k k))))

  (find-left-bound)
  (find-right-bound)

  (define max-score (vector-ref nums k))
  (define left-index k)
  (define right-index k)

  (define (calculate-max)
    (let loop ((i left-index))
      (if (>= i 0)
          (let ((current-max (vector-ref nums i)))
            (set! max-score (max max-score (* current-max (- right-index i 1))))
            (loop (sub1 i))))))

  (define (expand)
    (let loop ((l left-index) (r right-index))
      (if (or (< l 0) (>= r n))
          (set! max-score (max max-score (* (vector-ref nums l) (vector-ref nums r))))
          (begin
            (if (< (vector-ref nums l) (vector-ref nums r))
                (begin
                  (set! max-score (max max-score (* (vector-ref nums l) (vector-ref nums r))))
                  (loop (sub1 l) r))
                (begin
                  (set! max-score (max max-score (* (vector-ref nums l) (vector-ref nums r))))
                  (loop l (add1 r))))))))

  (calculate-max)
  (expand)
  max-score)