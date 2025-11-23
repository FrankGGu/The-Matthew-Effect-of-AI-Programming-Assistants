(define (minimize-hamming-distance nums1 nums2 allowed-swaps)
  (define n (length nums1))
  (define parent (make-vector n))
  (for ([i (in-range n)])
    (vector-set! parent i i))

  (define (find x)
    (if (= (vector-ref parent x) x)
        x
        (let ([root (find (vector-ref parent x))])
          (vector-set! parent x root)
          root)))

  (define (union x y)
    (let ([rootx (find x)]
          [rooty (find y)])
      (if (!= rootx rooty)
          (vector-set! parent rootx rooty))))

  (for ([swap allowed-swaps])
    (union (car swap) (cadr swap)))

  (define groups (make-hash))
  (for ([i (in-range n)])
    (let ([root (find i)])
      (if (hash-has-key? groups root)
          (hash-update! groups root (lambda (v) (cons i v)))
          (hash-set! groups root (list i)))))

  (define hamming-distance 0)
  (for ([root (hash-keys groups)])
    (let* ([indices (hash-ref groups root)]
           [group1 (map (lambda (i) (list-ref nums1 i)) indices)]
           [group2 (map (lambda (i) (list-ref nums2 i)) indices)]
           [freq1 (make-hash)]
           [freq2 (make-hash)])
      (for ([x group1])
        (if (hash-has-key? freq1 x)
            (hash-update! freq1 x add1)
            (hash-set! freq1 x 1)))
      (for ([x group2])
        (if (hash-has-key? freq2 x)
            (hash-update! freq2 x add1)
            (hash-set! freq2 x 1)))
      (for ([x (hash-keys freq2)])
        (let ([count1 (hash-ref freq1 x 0)]
              [count2 (hash-ref freq2 x)])
          (if (> count2 count1)
              (set! hamming-distance (+ hamming-distance (- count2 count1))))))))

  hamming-distance)