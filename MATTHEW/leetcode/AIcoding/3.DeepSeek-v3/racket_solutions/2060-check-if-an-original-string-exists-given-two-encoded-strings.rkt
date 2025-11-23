#lang racket

(define (possibly-equals s1 s2)
  (define n1 (string-length s1))
  (define n2 (string-length s2))
  (define memo (make-hash))

  (define (dfs i j diff)
    (define key (list i j diff))
    (hash-ref! memo key
      (lambda ()
        (cond
          [(and (>= i n1) (>= j n2)) (zero? diff)]
          [else
           (define (numeric? c) (and (char? c) (char-numeric? c)))
           (define (letter? c) (and (char? c) (char-alphabetic? c)))
           (define (get-nums i)
             (let loop ([i i] [nums '()] [current ""])
               (if (or (>= i n1) (not (numeric? (string-ref s1 i))))
                   (values nums i)
                   (let ([c (string-ref s1 i)])
                     (loop (add1 i) (cons (string->number (string current c)) (string-append current (string c))))))))
           (define (get-nums2 j)
             (let loop ([j j] [nums '()] [current ""])
               (if (or (>= j n2) (not (numeric? (string-ref s2 j))))
                   (values nums j)
                   (let ([c (string-ref s2 j)])
                     (loop (add1 j) (cons (string->number (string current c)) (string-append current (string c))))))))

           (define (try-letters i j diff)
             (cond
               [(and (>= i n1) (>= j n2)) (zero? diff)]
               [(or (>= i n1) (>= j n2)) #f]
               [(and (letter? (string-ref s1 i)) (letter? (string-ref s2 j)))
                (if (char=? (string-ref s1 i) (string-ref s2 j))
                    (dfs (add1 i) (add1 j) diff)
                    #f)]
               [else #f]))

           (define (try-nums i j diff)
             (let-values ([(nums1 next-i) (get-nums i)]
                         [(nums2 next-j) (get-nums2 j)])
               (cond
                 [(and (null? nums1) (null? nums2)) (try-letters i j diff)]
                 [(null? nums1) (for/or ([num (in-list nums2)])
                                  (dfs i next-j (- diff num)))]
                 [(null? nums2) (for/or ([num (in-list nums1)])
                                  (dfs next-i j (+ diff num)))]
                 [else (for*/or ([num1 (in-list nums1)]
                                 [num2 (in-list nums2)])
                         (dfs next-i next-j (+ diff (- num1 num2))))])))

           (try-nums i j diff)]))))

  (dfs 0 0 0))