(define (firstUniqueChar s)
  (let* ((char-count (make-hash)))
    (for-each (lambda (c)
                (hash-set! char-count c (+ 1 (hash-ref char-count c 0))))
              (string->list s))
    (for/fold ([index -1]) ([i (in-range (string-length s))])
      (if (and (>= index 0) (not (= (hash-ref char-count (string-ref s i)) 1)))
          index
          (if (= (hash-ref char-count (string-ref s i)) 1)
              i
              index)))))

(firstUniqueChar "leetcode")
(firstUniqueChar "loveleetcode")
(firstUniqueChar "aabb")