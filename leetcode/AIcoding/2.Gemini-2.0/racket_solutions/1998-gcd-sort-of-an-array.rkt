(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (find-max arr)
  (foldl max 0 arr))

(define (root parent i)
  (if (= (list-ref parent i) i)
      i
      (let ((r (root parent (list-ref parent i))))
        (list-set parent! i r)
        r)))

(define (union parent size i j)
  (let ((root-i (root parent i))
        (root-j (root parent j)))
    (if (= root-i root-j)
        void
        (if (< (list-ref size root-i) (list-ref size root-j))
            (begin
              (list-set parent! root-i root-j)
              (list-set size! root-j (+ (list-ref size root-j) (list-ref size root-i))))
            (begin
              (list-set parent! root-j root-i)
              (list-set size! root-i (+ (list-ref size root-i) (list-ref size root-j))))))))

(define (gcd-sort arr)
  (let* ((n (length arr))
         (max-val (find-max arr))
         (parent (list->vector (range n)))
         (size (list->vector (make-list n 1)))
         (factors (make-vector (add1 max-val) #f)))

    (for ((i (in-range n)))
      (let ((num (list-ref arr i)))
        (for ((j (in-range 2 (add1 (floor (sqrt num))))))
          (when (= (remainder num j) 0)
            (let ((factor1 j)
                  (factor2 (/ num j)))

              (unless (vector-ref factors factor1)
                (vector-set! factors factor1 i))
              (unless (vector-ref factors factor2)
                (vector-set! factors factor2 i))

              (union parent size i (vector-ref factors factor1))
              (union parent size i (vector-ref factors factor2)))))

        (unless (vector-ref factors num)
          (vector-set! factors num i))

        (union parent size i (vector-ref factors num))))

    (let* ((sorted-arr (sort arr <))
           (result #t))
      (for ((i (in-range n)))
        (unless (= (root parent i) (root parent (index-of arr (list-ref sorted-arr i))))
          (set! result #f)
          (break)))
      result)))

(define (index-of lst val)
  (let loop ((i 0) (l lst))
    (cond
      ((null? l) #f)
      ((equal? (car l) val) i)
      (else (loop (add1 i) (cdr l))))))