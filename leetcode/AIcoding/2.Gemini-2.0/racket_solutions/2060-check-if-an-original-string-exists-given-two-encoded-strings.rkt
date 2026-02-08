(define (is-valid s1 s2 i j memo)
  (cond
    [(and (= i (string-length s1)) (= j (string-length s2))) #t]
    [(or (= i (string-length s1)) (= j (string-length s2))) #f]
    [(hash-has-key? memo (cons i j)) (hash-ref memo (cons i j))]
    [else
     (let loop ([k 1])
       (cond
         [(> k (min (- (string-length s1) i) (- (string-length s2) j) 3)) #f]
         [(and (char-numeric? (string-ref s1 i)) (char-numeric? (string-ref s2 j)))
          (let ([num1 (string->number (substring s1 i (+ i k)))]
                [num2 (string->number (substring s2 j (+ j k)))])
            (cond
              [(or (null? num1) (null? num2)) #f]
              [(and (> num1 0) (> num2 0) (= num1 num2))
               (let ([result (is-valid s1 s2 (+ i k) (+ j k) memo)])
                 (hash-set! memo (cons i j) result)
                 result)]
              [else (loop (+ k 1))]))]
         [(char-numeric? (string-ref s1 i))
          (let ([num1 (string->number (substring s1 i (+ i k)))])
            (cond
              [(null? num1) #f]
              [(> num1 0)
               (let ([result (is-valid s1 s2 (+ i k) j memo)])
                 (hash-set! memo (cons i j) result)
                 result)]
              [else (loop (+ k 1))]))]
         [(char-numeric? (string-ref s2 j))
          (let ([num2 (string->number (substring s2 j (+ j k)))])
            (cond
              [(null? num2) #f]
              [(> num2 0)
               (let ([result (is-valid s1 s2 i (+ j k) memo)])
                 (hash-set! memo (cons i j) result)
                 result)]
              [else (loop (+ k 1))]))]
         [(char=? (string-ref s1 i) (string-ref s2 j))
          (let ([result (is-valid s1 s2 (+ i 1) (+ j 1) memo)])
            (hash-set! memo (cons i j) result)
            result)]
         [else #f]))])]))

(define (possibly-equals s1 s2)
  (is-valid s1 s2 0 0 (make-hash)))