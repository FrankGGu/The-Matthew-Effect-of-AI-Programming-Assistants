(define (maximum-segment-sum-after-removals nums removals)
  (define n (vector-length nums))
  (define m (vector-length removals))

  (define parent (make-vector n (lambda (i) i)))
  (define segment-sum (make-vector n 0))
  (define active (make-vector n #f))

  (define not-removed-indices (make-vector n #t))
  (for-each (lambda (idx) (vector-set! not-removed-indices idx #f)) removals)

  (define (find i)
    (if (= (vector-ref parent i) i)
        i
        (begin
          (vector-set! parent i (find (vector-ref parent i)))
          (vector-ref parent i))))

  (define (union-sets i j)
    (let ((root-i (find i))
          (root-j (find j)))
      (if (= root-i root-j)
          root-i
          (begin
            (vector-set! parent root-j root-i)
            (vector-set! segment-sum root-i
                         (+ (vector-ref segment-sum root-i)
                            (vector-ref segment-sum root-j)))
            root-i))))

  (define results '())
  (define current-max-sum 0)

  (for ((i (in-range n)))
    (when (vector-ref not-removed-indices i)
      (vector-set! active i #t)
      (vector-set! segment-sum i (vector-ref nums i))
      (set! current-max-sum (max current-max-sum (vector-ref segment-sum i)))

      (when (and (> i 0) (vector-ref active (- i 1)))
        (let ((new-root (union-sets i (- i 1))))
          (set! current-max-sum (max current-max-sum (vector-ref segment-sum new-root)))))))

  (set! results (cons current-max-sum results))

  (for ((k (in-range (- m 1) -1 -1)))
    (let* ((idx (vector-ref removals k)))
      (vector-set! active idx #t)
      (vector-set! segment-sum idx (vector-ref nums idx))
      (set! current-max-sum (max current-max-sum (vector-ref segment-sum idx)))

      (when (and (> idx 0) (vector-ref active (- idx 1)))
        (let ((new-root (union-sets idx (- idx 1))))
          (set! current-max-sum (max current-max-sum (vector-ref segment-sum new-root)))))

      (when (and (< idx (- n 1)) (vector-ref active (+ idx 1)))
        (let ((new-root (union-sets idx (+ idx 1))))
          (set! current-max-sum (max current-max-sum (vector-ref segment-sum new-root))))))

    (unless (= k 0)
      (set! results (cons current-max-sum results))))

  (reverse results))