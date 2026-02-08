(define (num-similar-groups strs)
  (define N (length strs))
  (define strs-vec (list->vector strs))

  (define parents (make-vector N 0))
  (for ([i (in-range N)])
    (vector-set! parents i i))

  (define (find i)
    (if (= (vector-ref parents i) i)
        i
        (let ((root (find (vector-ref parents i))))
          (vector-set! parents i root)
          root)))

  (define (union i j)
    (let ((root-i (find i))
          (root-j (find j)))
      (unless (= root-i root-j)
        (vector-set! parents root-j root-i))))

  (define (are-similar? s1 s2)
    (define len (string-length s1))
    (define diff1 -1)
    (define diff2 -1)
    (define diff-count 0)

    (for ([k (in-range len)])
      (when (not (char=? (string-ref s1 k) (string-ref s2 k)))
        (set! diff-count (add1 diff-count))
        (cond
          ((= diff1 -1) (set! diff1 k))
          ((= diff2 -1) (set! diff2 k))
          (else (void)))))

    (case diff-count
      [(0) #t]
      [(2) (and (char=? (string-ref s1 diff1) (string-ref s2 diff2))
                (char=? (string-ref s1 diff2) (string-ref s2 diff1)))]
      [else #f]))

  (for ([i (in-range N)])
    (for ([j (in-range (add1 i) N)])
      (when (are-similar? (vector-ref strs-vec i) (vector-ref strs-vec j))
        (union i j))))

  (define num-components 0)
  (for ([i (in-range N)])
    (when (= (vector-ref parents i) i)
      (set! num-components (add1 num-components))))
  num-components)