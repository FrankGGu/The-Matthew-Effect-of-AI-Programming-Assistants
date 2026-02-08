(define (shortest-string-that-contains-three-strings s1 s2 s3)

  (define (string-contains? full-string sub-string)
    (not (not (string-find/substring full-string sub-string))))

  (define (get-overlap-len s1 s2)
    (let* ((len1 (string-length s1))
           (len2 (string-length s2)))
      (let loop ((k (min len1 len2)))
        (if (= k 0)
            0
            (if (string=? (substring s1 (- len1 k)) (substring s2 0 k))
                k
                (loop (- k 1)))))))

  (define (merge-two s1 s2)
    (cond
      ((string-contains? s1 s2) s1)
      ((string-contains? s2 s1) s2)
      (else
       (let* ((len1 (string-length s1))
              (len2 (string-length s2))
              (overlap1 (get-overlap-len s1 s2))
              (overlap2 (get-overlap-len s2 s1))
              (res1 (string-append s1 (substring s2 overlap1)))
              (res2 (string-append s2 (substring s1 overlap2))))
         (cond
           ((< (string-length res1) (string-length res2)) res1)
           ((< (string-length res2) (string-length res1)) res2)
           (else (if (string<? res1 res2) res1 res2)))))))

  (let* ((permutations (list (list s1 s2 s3)
                             (list s1 s3 s2)
                             (list s2 s1 s3)
                             (list s2 s3 s1)
                             (list s3 s1 s2)
                             (list s3 s2 s1)))
         (min-res (string-append s1 s2 s3)))

    (for-each
     (lambda (p)
       (let* ((a (car p))
              (b (cadr p))
              (c (caddr p))
              (temp-res-ab (merge-two a b))
              (temp-res-abc (merge-two temp-res-ab c)))
         (when (or (< (string-length temp-res-abc) (string-length min-res))
                   (and (= (string-length temp-res-abc) (string-length min-res))
                        (string<? temp-res-abc min-res)))
           (set! min-res temp-res-abc))))
     permutations)
    min-res))