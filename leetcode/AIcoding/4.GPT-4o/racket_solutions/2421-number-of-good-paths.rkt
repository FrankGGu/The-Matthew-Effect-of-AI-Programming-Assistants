(define (numberOfGoodPaths vals edges)
  (define n (length vals))
  (define parent (make-vector n -1))
  (define rank (make-vector n 1))
  (define good-paths (make-vector n 1))

  (define (find x)
    (if (vector-ref parent x) 
        (set! (vector-ref parent x) (find (vector-ref parent x)))
        x))

  (define (union x y)
    (let ((rootX (find x))
          (rootY (find y)))
      (cond ((not (= rootX rootY))
             (if (> (vector-ref rank rootX) (vector-ref rank rootY))
                 (begin
                   (set! (vector-ref parent rootY) rootX)
                   (set! (vector-ref good-paths rootX) (+ (vector-ref good-paths rootX) (vector-ref good-paths rootY)))
                   (vector-set! rank rootX (1+ (vector-ref rank rootX))))
                 (begin
                   (set! (vector-ref parent rootX) rootY)
                   (set! (vector-ref good-paths rootY) (+ (vector-ref good-paths rootX) (vector-ref good-paths rootY)))
                   (vector-set! rank rootY (1+ (vector-ref rank rootY))))))))

  (define edges (map (lambda (i) (list (car (vector-ref edges i)) (cadr (vector-ref edges i)))) (range (length edges))))
  (define vals-with-index (map-indexed (lambda (i v) (list v i)) vals))
  (define sorted-vals (sort vals-with-index (lambda (a b) (< (car a) (car b)))))

  (for [(v sorted-vals)]
    (let ((val (car v))
          (index (cadr v)))
      (for [(edge edges)]
        (when (and (or (= index (car edge)) (= index (cadr edge)))
                   (<= (min (vector-ref vals (car edge)) (vector-ref vals (cadr edge))) val))
          (union (car edge) (cadr edge)))))
    (set! (vector-ref good-paths (find index)) (vector-ref good-paths (find index)))
    (for [(i (range n))]
      (when (= (find i) (find index))
        (vector-set! good-paths (find i) (+ (vector-ref good-paths (find i)) 1)))))

  (apply + (vector->list good-paths)))

(define (numberOfGoodPaths vals edges)
  (numberOfGoodPaths vals edges))