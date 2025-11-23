(define (subarray-with-elements-greater-than-varying-threshold nums threshold)
  (define n (length nums))
  (define result (make-vector n #f))
  (define (solve)
    (let loop ([i 0])
      (when (< i n)
        (when (>= (list-ref nums i) (threshold i))
          (vector-set! result i #t))
        (loop (+ i 1)))))
  (solve)
  (let loop ([i 0] [start -1])
    (cond
      [(= i n) #f]
      [(vector-ref result i)
       (if (= start -1)
           (loop (+ i 1) i)
           (loop (+ i 1) start))]
      [else
       (if (= start -1)
           (loop (+ i 1) -1)
           (begin
             (when (and (> (- i start) 0) (not (vector-ref result (- i 1))))
               (let ([j (- i 1)])
                 (when (and (>= j 0) (vector-ref result j))
                   (let ([k (- j start)])
                     (if (>= k 1)
                         (begin
                           (vector-set! result start #t)
                           (vector-set! result j #t)
                           (let loop2 ([m (+ start 1)] [n j])
                             (when (< m n)
                               (vector-set! result m #t)
                               (loop2 (+ m 1) n))))))
                     (loop (+ i 1) -1))))
               (loop (+ i 1) -1)))])))
  (let loop ([i 0] [start -1])
    (cond
      [(= i n) #f]
      [(vector-ref result i)
       (if (= start -1)
           (loop (+ i 1) i)
           (loop (+ i 1) start))]
      [else
       (if (= start -1)
           (loop (+ i 1) -1)
           (begin
             (when (and (> (- i start) 0) (not (vector-ref result (- i 1))))
               (let ([j (- i 1)])
                 (when (and (>= j 0) (vector-ref result j))
                   (let ([k (- j start)])
                     (if (>= k 1)
                         (begin
                           (vector-set! result start #t)
                           (vector-set! result j #t)
                           (let loop2 ([m (+ start 1)] [n j])
                             (when (< m n)
                               (vector-set! result m #t)
                               (loop2 (+ m 1) n))))))
                     (loop (+ i 1) -1))))
               (loop (+ i 1) -1)))])))
  (let loop ([i 0] [start -1])
    (cond
      [(= i n) #f]
      [(vector-ref result i)
       (if (= start -1)
           (loop (+ i 1) i)
           (loop (+ i 1) start))]
      [else
       (if (= start -1)
           (loop (+ i 1) -1)
           (begin
             (when (and (> (- i start) 0) (not (vector-ref result (- i 1))))
               (let ([j (- i 1)])
                 (when (and (>= j 0) (vector-ref result j))
                   (let ([k (- j start)])
                     (if (>= k 1)
                         (begin
                           (vector-set! result start #t)
                           (vector-set! result j #t)
                           (let loop2 ([m (+ start 1)] [n j])
                             (when (< m n)
                               (vector-set! result m #t)
                               (loop2 (+ m 1) n))))))
                     (loop (+ i 1) -1))))
               (loop (+ i 1) -1)))])))
  (let loop ([i 0] [start -1])
    (cond
      [(= i n) #f]
      [(vector-ref result i)
       (if (= start -1)
           (loop (+ i 1) i)
           (loop (+ i 1) start))]
      [else
       (if (= start -1)
           (loop (+ i 1) -1)
           (begin
             (when (and (> (- i start) 0) (not (vector-ref result (- i 1))))
               (let ([j (- i 1)])
                 (when (and (>= j 0) (vector-ref result j))
                   (let ([k (- j start)])
                     (if (>= k 1)
                         (begin
                           (vector-set! result start #t)
                           (vector-set! result j #t)
                           (let loop2 ([m (+ start 1)] [n j])
                             (when (< m n)
                               (vector-set! result m #t)
                               (loop2 (+ m 1) n))))))
                     (loop (+ i 1) -1))))
               (loop (+ i 1) -1)))])))
  (let loop ([i 0] [start -1])
    (cond
      [(= i n) #f]
      [(vector-ref result i)
       (if (= start -1)
           (loop (+ i 1) i)
           (loop (+ i 1) start))]
      [else
       (if (= start -1)
           (loop (+ i 1) -1)
           (begin
             (when (and (> (- i start) 0) (not (vector-ref result (- i 1))))
               (let ([j (- i 1)])
                 (when (and (>= j 0) (vector-ref result j))
                   (let ([k (- j start)])
                     (if (>= k 1)
                         (begin
                           (vector-set! result start #t)
                           (vector-set! result j #t)
                           (let loop2 ([m (+ start 1)] [n j])
                             (when (< m n)
                               (vector-set! result m #t)
                               (loop2 (+ m 1) n))))))
                     (loop (+ i 1) -1))))
               (loop (+ i 1) -1)))])))
  (let loop ([i 0] [start -1])
    (cond
      [(= i n) #f]
      [(vector-ref result i)
       (if (= start -1)
           (loop (+ i 1) i)
           (loop (+ i 1) start))]
      [else
       (if (= start -1)
           (loop (+ i 1) -1)
           (begin
             (when (and (> (- i start) 0) (not (vector-ref result (- i 1))))
               (let ([j (- i 1)])
                 (when (and (>= j 0) (vector-ref result j))
                   (let ([k (- j start)])
                     (if (>= k 1)
                         (begin
                           (vector-set! result start #t)
                           (vector-set! result j #t)
                           (let loop2 ([m (+ start 1)] [n j])
                             (when (< m n)
                               (vector-set! result m #t)
                               (loop2 (+ m 1) n))))))
                     (loop (+ i 1) -1))))
               (loop (+ i 1) -1)))])))
  (let loop ([i 0] [start -1])
    (cond
      [(= i n) #f]
      [(vector-ref result i)
       (if (= start -1)
           (loop (+ i 1) i)
           (loop (+ i 1) start))]
      [else
       (if (= start -1)
           (loop (+ i 1) -1)
           (begin
             (when (and (> (- i start) 0) (not (vector-ref result (- i 1))))
               (let ([j (- i 1)])
                 (when (and (>= j 0) (vector-ref result j))
                   (let ([k (- j start)])
                     (if (>= k 1)
                         (begin
                           (vector-set! result start #t)
                           (vector-set! result j #t)
                           (let loop2 ([m (+ start 1)] [n j])
                             (when (< m n)
                               (vector-set! result m #t)
                               (loop2 (+ m 1) n))))))
                     (loop (+ i 1) -1))))
               (loop (+ i 1) -1)))])))
  (let loop ([i 0] [start -1])
    (cond
      [(= i n) #f]
      [(vector-ref result i)
       (if (= start -1)
           (loop (+ i 1) i)
           (loop (+ i 1) start))]
      [else
       (if (= start -1)
           (loop (+ i 1) -1)
           (begin
             (when (and (> (- i start) 0) (not (vector-ref result (- i 1))))
               (let ([j (- i 1)])
                 (when (and (>= j 0) (vector-ref result j))
                   (let ([