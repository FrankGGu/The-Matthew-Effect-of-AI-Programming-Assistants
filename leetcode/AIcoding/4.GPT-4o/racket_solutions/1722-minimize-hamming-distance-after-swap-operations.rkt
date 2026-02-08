(define (minimize-hamming-distance A B swaps)
  (define n (length A))
  (define parent (vector-fill (make-vector n) -1))

  (define (find x)
    (if (= (vector-ref parent x) -1)
        x
        (let ([root (find (vector-ref parent x))])
          (vector-set! parent x root)
          root)))

  (define (union x y)
    (define rootX (find x))
    (define rootY (find y))
    (when (not (= rootX rootY))
      (vector-set! parent rootX rootY)))

  (for ([swap swaps])
    (union (car swap) (cadr swap)))

  (define groups (make-hash))
  (for ([i (in-range n)])
    (let ([root (find i)])
      (hash-update! groups root (lambda (lst) (cons (vector-ref A i) lst)) '())))

  (define b-count (make-hash))
  (for ([b B])
    (hash-update! b-count b (lambda (count) (+ count 1)) 0))

  (define hamming-distance 0)
  (for ([group (in-hash groups)])
    (let ([values (hash-ref groups group)])
      (for ([v values])
        (if (> (hash-ref b-count v 0) 0)
            (hash-set! b-count v (sub1 (hash-ref b-count v)))
            (set! hamming-distance (add1 hamming-distance))))))

  hamming-distance)