(define (score-of-students s answers)
  (define (tokenize str)
    (let loop ([str str] [tokens '()])
      (cond
        [(string=? str "") (reverse tokens)]
        [(char-numeric? (string-ref str 0))
         (let loop2 ([str str] [num ""])
           (if (and (not (string=? str "")) (char-numeric? (string-ref str 0)))
               (loop2 (substring str 1) (string-append num (string (string-ref str 0))))
               (loop (substring str) (cons (string->number num) tokens))))]
        [(or (char=? (string-ref str 0) #\+) (char=? (string-ref str 0) #\*))
         (loop (substring str 1) (cons (string (string-ref str 0)) tokens))]
        [else (loop (substring str 1) tokens)])))

  (define tokens (tokenize s))

  (define (calculate-correct tokens)
    (define (eval tokens)
      (cond
        [(null? tokens) 0]
        [(null? (cdr tokens)) (car tokens)]
        [else
         (let ([op (cadr tokens)])
           (cond
             [(string=? op "+") (+ (car tokens) (eval (cddr tokens)))]
             [(string=? op "*") (* (car tokens) (eval (cddr tokens)))]
             [else 0]))]))
    (eval tokens))

  (define correct-ans (calculate-correct tokens))

  (define (calculate-possible tokens)
    (define n (length tokens))
    (define dp (make-vector (add1 n) (make-vector (add1 n) #f)))
    (for ([i (in-range 0 n)])
      (if (number? (list-ref tokens i))
          (vector-set! (vector-ref dp i) (add1 i) (set (list-ref tokens i)))))

    (for ([len (in-range 3 (add1 n))])
      (for ([i (in-range 0 (- n len -1))])
        (let ([j (+ i len)])
          (for ([k (in-range (add1 i) (- j 1))])
            (let ([left (vector-ref dp i) (add1 k)] [right (vector-ref dp (add1 k)) j])
              (let ([op (list-ref tokens k)])
                (if (and left right)
                    (for ([l (in-set left)] [r (in-set right)])
                      (let ([res (cond
                                     [(string=? op "+") (+ l r)]
                                     [(string=? op "*") (* l r)]
                                     [else #f])])
                        (if (and res (<= res 1000))
                            (if (not (vector-ref dp i) j)
                                (vector-set! (vector-ref dp i) j (set res))
                                (vector-set! (vector-ref dp i) j (set-add (vector-ref dp i) j res))))))))))))))
    (vector-ref dp 0) n)

  (define possible-ans (calculate-possible tokens))

  (define score 0)
  (for ([ans (in-list answers)])
    (cond
      [(equal? ans correct-ans) (set! score (+ score 5))]
      [(set-member? possible-ans ans) (set! score (+ score 2))]
      [else #f]))
  score)