(define (make-top-voted-candidate times persons)
  (let loop ([i 0] [votes (make-hash)] [lead -1] [lead-time -1] [result '()])
    (cond
      [(>= i (length times)) (reverse result)]
      [else
       (let ([time (list-ref times i)]
             [person (list-ref persons i)])
         (hash-update! votes person add1 0)
         (let ([vote-count (hash-ref votes person)])
           (if (> vote-count (if (equal? lead -1) 0 (hash-ref votes lead 0)))
               (loop (+ i 1) votes person time (cons (cons time person) result))
               (if (= vote-count (if (equal? lead -1) 0 (hash-ref votes lead 0)))
                   (if (< person lead)
                       (loop (+ i 1) votes lead lead-time (cons (cons time person) result))
                       (loop (+ i 1) votes lead lead-time (cons (cons time lead) result)))
                   (loop (+ i 1) votes lead lead-time (cons (cons time lead) result))))))])))

(define (make-top-voted-candidate-query top-voted-candidates)
  (lambda (t)
    (let loop ([candidates top-voted-candidates])
      (cond
        [(null? candidates) #f]
        [else
         (let ([candidate (car candidates)]
               [time (car candidate)]
               [person (cdr candidate)])
           (if (<= time t)
               (let loop2 ([rest (cdr candidates)])
                 (cond
                   [(null? rest) person]
                   [else
                    (let ([next-candidate (car rest)]
                          [next-time (car next-candidate)])
                      (if (<= next-time t)
                          (loop2 (cdr rest))
                          person))]))
               (loop (cdr candidates))))]))))

(define (top-voted-candidate-constructor times persons)
  (let ([top-voted-candidates (make-top-voted-candidate times persons)])
    (lambda (method . args)
      (case method
        [(query) (apply (make-top-voted-candidate-query top-voted-candidates) args)]
        [else (error "Invalid method")])))
  )