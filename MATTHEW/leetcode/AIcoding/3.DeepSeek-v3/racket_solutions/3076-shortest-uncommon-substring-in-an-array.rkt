(define (shortest-uncommon-substring arr)
  (define (all-substrings s)
    (let loop ((i 0) (res '()))
      (if (>= i (string-length s))
          res
          (loop (add1 i)
                (append res
                        (for/list ([j (in-range (add1 i) (add1 (string-length s))])
                          (substring s i j)))))))

  (define sub-freq (make-hash))
  (for ([s arr])
    (define subs (all-substrings s))
    (for ([sub subs])
      (hash-update! sub-freq sub (lambda (v) (add1 v)) 0)))

  (define candidates
    (sort (filter (lambda (sub) (= (hash-ref sub-freq sub) 1))
                  (hash-keys sub-freq))
          (lambda (a b)
            (or (< (string-length a) (string-length b))
                (and (= (string-length a) (string-length b))
                     (string<? a b))))))

  (if (null? candidates)
      ""
      (car candidates)))