(define (count-substrings s t)
  (define (char-count str)
    (foldl (lambda (c acc) (hash-update! acc c (lambda (x) (add1 x)) 0)) (make-hash) str))

  (define s-count (char-count s))
  (define t-count (char-count t))

  (define (can-rearrange? s-count t-count)
    (for/fold ([result #t]) ([key (hash-keys t-count)])
      (if (hash-ref s-count key 0) 
          (and result (>= (hash-ref s-count key 0) (hash-ref t-count key 0)))
          #f)))

  (define (count-valid substr)
    (and (can-rearrange? (char-count substr) t-count)))

  (define (count-substrings-helper start end count)
    (if (>= start (string-length s))
        count
        (if (< end (string-length s))
            (count-substrings-helper start (+ end 1) count)
            (count-substrings-helper (+ start 1) (+ start 1) 
              (if (count-valid (substring s start (+ start 1)))
                  (+ count 1)
                  count)))))

  (count-substrings-helper 0 0 0))

(define (count-substrings-main s t)
  (count-substrings s t))