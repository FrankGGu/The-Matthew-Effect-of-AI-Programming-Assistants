(define (minimize-concatenation strs)
  (define (dp i left right memo)
    (cond
      [(>= i (length strs)) 0]
      [(hash-has-key? memo (list i left right)) (hash-ref memo (list i left right))]
      [else
       (define str (list-ref strs i))
       (define cost1
         (+ (string-length str)
            (if (char=? (string-ref str 0) right)
                -1
                0)
            (dp (+ i 1) left (string-ref str (- (string-length str) 1)) memo)))
       (define cost2
         (+ (string-length str)
            (if (char=? (string-ref str (- (string-length str) 1)) left)
                -1
                0)
            (dp (+ i 1) (string-ref str 0) right memo)))
       (define result (min cost1 cost2))
       (hash-set! memo (list i left right) result)
       result]))

  (define first-str (list-ref strs 0))
  (define memo (make-hash))
  (+ (string-length first-str)
     (dp 1 (string-ref first-str 0) (string-ref first-str (- (string-length first-str) 1)) memo)))