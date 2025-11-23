#lang racket

(define (compute-lps pattern)
  (let* ([m (string-length pattern)]
         [lps (make-vector m 0)])
    (let loop ([len 0] [i 1])
      (cond
        [(= i m) lps]
        [(char=? (string-ref pattern i) (string-ref pattern len))
         (vector-set! lps i (+ len 1))
         (loop (+ len 1) (+ i 1))]
        [(> len 0)
         (loop (vector-ref lps (- len 1)) i)]
        [else
         (vector-set! lps i 0)
         (loop 0 (+ i 1))])))

(define (kmp-search text pattern lps)
  (let* ([n (string-length text)]
         [m (string-length pattern)])
    (let loop ([i 0] [j 0] [result '()]) ; i for text, j for pattern
      (cond
        [(= i n) (reverse result)] ; End of text
        [(char=? (string-ref text i) (string-ref pattern j))
         (let ([next-i (+ i 1)]
               [next-j (+ j 1)])
           (if (= next-j m) ; Full pattern match
               (loop next-i (vector-ref lps (- next-j 1)) (cons (- next-i m) result))
               (loop next-i next-j result)))]
        [else ; Mismatch
         (if (> j 0)
             (loop i (vector-ref lps (- j 1)) result)
             (loop (+ i 1) j result))]))))

(define (find-beautiful-indices s a b k)
  (let* ([lps-a (compute-lps a)]
         [lps-b (compute-lps b)]
         [indices-a (kmp-search s a lps-a)]
         [indices-b (kmp-search s b lps-b)])

    (let loop-a ([res '()] [ptr-a 0] [ptr-b 0])
      (if (= ptr-a (length indices-a))
          (reverse res)
          (let* ([i (list-ref indices-a ptr-a)]
                 [len-b (length indices-b)])
            (let advance-b ([current-ptr-b ptr-b])
              (cond
                [(= current-ptr-b len-b)
                 (loop-a res (+ ptr-a 1) current-ptr-b)]
                [(< (list-ref indices-b current-ptr-b) (- i k))
                 (advance-b (+ current-ptr-b 1))]
                [else
                 (if (<= (list-ref indices-b current-ptr-b) (+ i k))
                     (loop-a (cons i res) (+ ptr-a 1) current-ptr-b)
                     (loop-a res (+ ptr-a 1) current-ptr-b))])))))))