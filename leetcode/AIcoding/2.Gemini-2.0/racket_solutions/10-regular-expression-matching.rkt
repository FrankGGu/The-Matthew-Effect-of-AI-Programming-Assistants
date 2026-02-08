(define (is-match s p)
  (define (memoize f)
    (let ((cache (make-hash)))
      (lambda args
        (let ((key (list->string (map (lambda (x) (if (string? x) x (number->string x))) args))))
          (if (hash-has-key? cache key)
              (hash-ref cache key)
              (let ((result (apply f args)))
                (hash-set! cache key result)
                result))))))

  (define (match-recursive s-idx p-idx)
    (memoize
     (lambda (s-idx p-idx)
       (cond
         [(and (= s-idx (string-length s)) (= p-idx (string-length p))) #t]
         [(= p-idx (string-length p)) #f]
         [else
          (let* ((first-match (and (< s-idx (string-length s))
                                   (or (= (string-ref s s-idx) (string-ref p p-idx))
                                       (= (string-ref p p-idx) #\.))))
                 (next-char (if (< (+ p-idx 1) (string-length p)) (string-ref p (+ p-idx 1)) #f)))
            (if (equal? next-char #\*)
                (or (match-recursive s-idx (+ p-idx 2))
                    (and first-match (match-recursive (+ s-idx 1) p-idx)))
                (and first-match (match-recursive (+ s-idx 1) (+ p-idx 1))))))])))
  (match-recursive 0 0))