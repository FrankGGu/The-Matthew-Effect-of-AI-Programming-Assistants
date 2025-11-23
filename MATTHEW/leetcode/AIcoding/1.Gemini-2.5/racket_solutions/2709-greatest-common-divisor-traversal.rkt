(define (greatest-common-divisor-traversal nums)
  (define MAX-VAL 100000)

  ;; Handle base cases
  (cond
    [(= (length nums) 1) #t]
    [(member 1 nums) #f] ; If 1 is present and length > 1, it's impossible to connect
    [else
     ;; DSU implementation
     (define parent (make-vector (+ MAX-VAL 1)))
     (for ([i (in-range (+ MAX-VAL 1))])
       (vector-set! parent i i))

     (define (find i)
       (if (= (vector-ref parent i) i)
           i
           (let ([root (find (vector-ref parent i))])
             (vector-set! parent i root)
             root)))

     (define (union i j)
       (let ([root-i (find i)]
             [root-j (find j)])
         (unless (= root-i root-j)
           (vector-set! parent root-j root-i))))

     ;; Sieve for smallest prime factor (SPF)
     (define spf (make-vector (+ MAX-VAL 1) 0))
     (for ([i (in-range 2 (+ MAX-VAL 1))])
       (vector-set! spf i i))

     (for ([i (in-range 2 (add1 (sqrt MAX-VAL)))])
       (when (= (vector-ref spf i) i)
         (for ([j (in-range (* i i) (+ MAX-VAL 1) i)])
           (when (= (vector-ref spf j) j)
             (vector-set! spf j i)))))

     ;; Function to get distinct prime factors using SPF
     (define (get-distinct-prime-factors n)
       (define factors-set (make-hash))
       (let loop ([num n])
         (when (> num 1)
           (let ([p (vector-ref spf num)])
             (hash-set! factors-set p #t)
             (loop (/ num p)))))
       (hash-keys factors-set))

     ;; Process each number in nums
     (define first-num (car (filter (lambda (x) (> x 1)) nums)))

     (for ([num (in-list nums)])
       (when (> num 1)
         (let ([factors (get-distinct-prime-factors num)])
           (for ([factor (in-list factors)])
             (union num factor)))))

     ;; Check connectivity
     (let ([root-of-first (find first-num)])
       (define all-connected? #t)
       (for ([num (in-list nums)])
         (when (> num 1)
           (unless (= (find num) root-of-first)
             (set! all-connected? #f)
             (break))))
       all-connected?)]))