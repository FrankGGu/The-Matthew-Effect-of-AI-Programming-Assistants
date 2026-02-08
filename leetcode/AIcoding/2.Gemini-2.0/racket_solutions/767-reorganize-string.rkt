(define (reorganize-string s)
  (define counts (make-hash))
  (for ([c (in-string s)])
    (hash-update! counts c (λ (x) (+ x 1)) 1))

  (define pq (make-heap < (λ (x y) (> (cdr x) (cdr y)))))
  (for ([(c cnt) (in-hash counts)])
    (heap-add! pq (cons c cnt)))

  (define result "")
  (define prev #f)
  (define (build-string)
    (if (heap-empty? pq)
        result
        (let* ([curr (heap-remove-min! pq)]
               [c (car curr)]
               [cnt (cdr curr)])
          (set! result (string-append result (string c)))
          (if prev
              (heap-add! pq prev))
          (if (> cnt 1)
              (set! prev (cons c (- cnt 1)))
              (set! prev #f))
          (build-string))))

  (let ([ans (build-string)])
    (if (= (string-length ans) (string-length s))
        ans
        "")))