(define (number-of-ways hats)
  (define n (length hats))
  (define max-hat-id 40)
  (define modulo 1000000007)

  (define people-who-like-hat (make-vector (+ max-hat-id 1) null))
  (for ([person-idx (in-range n)])
    (for ([hat-id (list-ref hats person-idx)])
      (vector-set! people-who-like-hat hat-id
                   (cons person-idx (vector-ref people-who-like-hat hat-id)))))

  (define memo (make-hash))

  (letrec ([dp (lambda (h mask)
                 (let ([cached (hash-ref memo (list h mask) #f)])
                   (if cached
                       cached
                       (let ([result
                              (cond
                                [(= mask (sub1 (arithmetic-shift 1 n))) 1]
                                [(> h max-hat-id) 0]
                                [else
                                 (let ([current-ways (dp (+ h 1) mask)])
                                   (for ([person-idx (vector-ref people-who-like-hat h)])
                                     (unless (logbit? person-idx mask)
                                       (set! current-ways
                                             (modulo (+ current-ways (dp (+ h 1) (logior mask (arithmetic-shift 1 person-idx))))
                                                     modulo))))
                                   current-ways)])])
                         (hash-set! memo (list h mask) result)
                         result))))])
    (dp 1 0)))