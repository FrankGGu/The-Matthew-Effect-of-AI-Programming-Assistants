(define (maximize-grid-happiness m n introverts extroverts)
  (define EMPTY 0)
  (define INTROVERT 1)
  (define EXTROVERT 2)

  (define base-scores (vector 0 120 40))

  (define adj-scores
    (vector
     (vector 0 0 0)
     (vector 0 -30 -10)
     (vector 0 -10 20)))

  (define powers-of-3 (make-vector n))
  (for ([k (in-range n)])
    (vector-set! powers-of-3 k (expt 3 k)))

  (define (get-type mask c)
    (if (or (< c 0) (>= c n))
        EMPTY
        (remainder (quotient mask (vector-ref powers-of-3 c)) 3)))

  (define dp (make-vector (+ m 1)))
  (for ([r (in-range (+ m 1))])
    (vector-set! dp r (make-vector (+ introverts 1))))
  (for ([r (in-range (+ m 1))])
    (for ([i (in-range (+ introverts 1))])
      (vector-set! (vector-ref dp r) i (make-vector (+ extroverts 1)))))
  (for ([r (in-range (+ m 1))])
    (for ([i (in-range (+ introverts 1))])
      (for ([e (in-range (+ extroverts 1))])
        (vector-set! (vector-ref (vector-ref dp r) i) e (make-vector (expt 3 n) -1)))))

  (define (solve r i e prev-mask)
    (cond
      ((= r m) 0)
      ((not (= (vector-ref (vector-ref (vector-ref dp r) i) e prev-mask) -1))
       (vector-ref (vector-ref (vector-ref dp r) i) e prev-mask))
      (else
       (let ((max-happiness-for-row (solve-row r 0 i e 0 prev-mask)))
         (vector-set! (vector-ref (vector-ref (vector-ref dp r) i) e prev-mask) max-happiness-for-row)
         max-happiness-for-row))))

  (define (solve-row current-r c i e current-row-mask prev-row-mask)
    (cond
      ((= c n)
       (solve (+ 1 current-r) i e current-row-mask))
      (else
       (let* ((max-val 0)
              (up-type (get-type prev-row-mask c))
              (left-type (if (> c 0) (get-type current-row-mask (- c 1)) EMPTY)))

         (set! max-val (max max-val (solve-row current-r (+ 1 c) i e current-row-mask prev-row-mask)))

         (when (> i 0)
           (let* ((current-score (vector-ref base-scores INTROVERT))
                  (adj-up-score (vector-ref (vector-ref adj-scores INTROVERT) up-type))
                  (adj-left-score (vector-ref (vector-ref adj-scores INTROVERT) left-type))
                  (next-current-row-mask (+ current-row-mask (* INTROVERT (vector-ref powers-of-3 c)))))
             (set! max-val (max max-val
                                (+ current-score adj-up-score adj-left-score
                                   (solve-row current-r (+ 1 c) (- i 1) e next-current-row-mask prev-row-mask))))))

         (when (> e 0)
           (let* ((current-score (vector-ref base-scores EXTROVERT))
                  (adj-up-score (vector-ref (vector-ref adj-scores EXTROVERT) up-type))
                  (adj-left-score (vector-ref (vector-ref adj-scores EXTROVERT) left-type))
                  (next-current-row-mask (+ current-row-mask (* EXTROVERT (vector-ref powers-of-3 c)))))
             (set! max-val (max max-val
                                (+ current-score adj-up-score adj-left-score
                                   (solve-row current-r (+ 1 c) i (- e 1) next-current-row-mask prev-row-mask))))))
         max-val))))

  (solve 0 introverts extroverts 0))