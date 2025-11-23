(define (two-out-of-three nums1 nums2 nums3)
  (define (count-occurrences lst)
    (for/fold ([m (hash)]) ([n lst])
      (hash-update m n add1 0)))
  (define h1 (count-occurrences nums1))
  (define h2 (count-occurrences nums2))
  (define h3 (count-occurrences nums3))
  (for/list ([k (in-hash-keys h1)])
    (if (or (hash-has-key? h2 k) (hash-has-key? h3 k))
        k
        #f))
  (filter values
          (for/list ([k (in-hash-keys h1)])
            (if (or (hash-has-key? h2 k) (hash-has-key? h3 k))
                k
                #f))))