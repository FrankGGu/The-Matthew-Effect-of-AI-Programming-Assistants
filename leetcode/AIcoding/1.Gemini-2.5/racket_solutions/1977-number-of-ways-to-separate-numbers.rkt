(define (number-of-ways num)
  (let* ((n (string-length num))
         (MOD 1000000007)
         (lcp (make-vector (+ n 1) (lambda () (make-vector (+ n 1) 0))))
         (dp (make-vector (+ n 1) (lambda () (make-vector (+ n 1) 0))))
         (prefix-sum-dp-len (make-vector (+ n 1) (lambda () (make-vector (+ n 1) 0)))))

    ;; Precompute LCP table
    (for-each (lambda (i) ; i from n-1 down to 0
                (for-each (lambda (j) ; j from n-1 down to 0
                            (when (and (< i n) (< j n) (char=? (string-ref num i) (string-ref num j)))
                              (vector-set! (vector-ref lcp i) j (+ 1 (vector-ref (vector-ref lcp (+ i 1)) (+ j 1))))))
                          (reverse (build-list n identity))))
              (reverse (build-list n identity)))

    ;; Base case for prefix-sum-dp-len
    (vector-set! (vector-ref dp 0) 0 1)
    (vector-set! (vector-ref prefix-sum-dp-len 0) 0 1)

    (for-each (lambda (i) ; i from 1 to n (current end index)
                (for-each (lambda (len) ; len from 1 to i (length of current number)
                            (let* ((start-curr (- i len))
                                   (current-ways 0))
                              (when (>= start-curr 0)
                                (cond
                                  ((char=? (string-ref num start-curr) #\0)
                                   (when (= len 1) ; s_curr is "0"
                                     (when (= start-curr 0) ; num starts with "0", and this is the first number
                                       (set! current-ways 1))))
                                  (else ; num[start-curr] != '0'. Valid number.
                                    (when (= start-curr 0) ; First number in sequence
                                      (set! current-ways 1))
                                    (unless (= start-curr 0)
                                      ;; Case 1: prev_len < len
                                      (let ((upper-bound-prev-len (min start-curr (- len 1))))
                                        (when (>= upper-bound-prev-len 1)
                                          (set! current-ways
                                                (modulo (+ current-ways (vector-ref (vector-ref prefix-sum-dp-len start-curr) upper-bound-prev-len)) MOD)))))

                                    ;; Case 2: prev_len == len
                                    (let ((prev-len-eq-len len)
                                          (start-prev (- start-curr len)))
                                      (when (and (>= start-prev 0) (not (= start-curr 0)))
                                        ;; Check if s_curr > s_prev
                                        (let ((l (vector-ref (vector-ref lcp start-curr) start-prev)))
                                          (when (and (< l len) (> (char->integer (string-ref num (+ start-curr l))) (char->integer (string-ref num (+ start-prev l)))))
                                            (set! current-ways
                                                  (modulo (+ current-ways (vector-ref (vector-ref dp start-curr) prev-len-eq-len)) MOD))))))))
                              (vector-set! (vector-ref dp i) len current-ways)))
                          (build-list i add1))) ; len

                ;; Update prefix sums for i
                (vector-set! (vector-ref prefix-sum-dp-len i) 0 0)
                (for-each (lambda (len)
                            (vector-set! (vector-ref prefix-sum-dp-len i) len
                                         (modulo (+ (vector-ref (vector-ref prefix-sum-dp-len i) (- len 1))
                                                    (vector-ref (vector-ref dp i) len))
                                                 MOD)))
                          (build-list i add1))) ; len
              (build-list n add1)) ; i

    (vector-ref (vector-ref prefix-sum-dp-len n) n)))