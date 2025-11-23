(define (recover-array nums)
  (define n (length nums))
  (define half-n (/ n 2))

  (define sorted-nums (sort nums <))

  (define (make-freq-map lst)
    (define freq (make-hash))
    (for-each (lambda (x)
                (hash-set! freq x (+ (hash-ref freq x 0) 1)))
              lst)
    freq)

  (define initial-freq (make-freq-map sorted-nums))

  (define (try-k k-val)
    (define current-freq (hash-copy initial-freq))
    (define current-original '())
    (define possible #true)

    (for-each (lambda (val)
                (when (and possible (> (hash-ref current-freq val 0) 0))
                  (define x val)
                  (define y (+ x k-val))
                  (if (> (hash-ref current-freq y 0) 0)
                      (begin
                        (set! current-original (cons x current-original))
                        (hash-set! current-freq x (- (hash-ref current-freq x) 1))
                        (hash-set! current-freq y (- (hash-ref current-freq y) 1)))
                      (set! possible #false))))
              sorted-nums)

    (if (and possible (= (length current-original) half-n))
        (reverse current-original)
        #false))

  (define x0 (car sorted-nums))
  (define k-candidates
    (remove-duplicates
     (filter (lambda (k) (> k 0))
             (map (lambda (num_j) (- num_j x0)) (cdr sorted-nums)))))

  (define (find-solution candidates)
    (if (empty? candidates)
        '()
        (let ([k (car candidates)])
          (let ([result (try-k k)])
            (if result
                result
                (find-solution (cdr candidates)))))))

  (find-solution k-candidates))