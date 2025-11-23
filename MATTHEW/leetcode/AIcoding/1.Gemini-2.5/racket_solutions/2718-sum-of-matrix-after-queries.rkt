(require racket/set)

(define (sum-of-matrix-after-queries n queries)
  (let loop ((q-idx (- (length queries) 1))
             (total-sum 0)
             (rows-set (set))
             (cols-set (set))
             (rows-count 0)
             (cols-count 0))
    (if (or (< q-idx 0)
            (and (= rows-count n) (= cols-count n)))
        total-sum
        (let* ((query (list-ref queries q-idx))
               (type (list-ref query 0))
               (index (list-ref query 1))
               (val (list-ref query 2)))
          (cond
            ((= type 0) ; Row query
             (if (not (set-member? rows-set index))
                 (loop (- q-idx 1)
                       (+ total-sum (* val (- n cols-count)))
                       (set-add rows-set index)
                       cols-set
                       (+ rows-count 1)
                       cols-count)
                 (loop (- q-idx 1)
                       total-sum
                       rows-set
                       cols-set
                       rows-count
                       cols-count)))
            ((= type 1) ; Column query
             (if (not (set-member? cols-set index))
                 (loop (- q-idx 1)
                       (+ total-sum (* val (- n rows-count)))
                       rows-set
                       (set-add cols-set index)
                       rows-count
                       (+ cols-count 1))
                 (loop (- q-idx 1)
                       total-sum
                       rows-set
                       cols-set
                       rows-count
                       cols-count)))
            (else
             (error "Invalid query type")))))))