(define (compareVersion version1 version2)
  (define (split-version version)
    (map string->number (string-split version "\\.")))
  (define vs1 (split-version version1))
  (define vs2 (split-version version2))
  (define len1 (length vs1))
  (define len2 (length vs2))
  (define max-len (max len1 len2))
  (for/fold ([result 0]) ([i (in-range max-len)])
    (let* ([v1 (if (< i len1) (list-ref vs1 i) 0)]
           [v2 (if (< i len2) (list-ref vs2 i) 0)])
      (cond
        [(> v1 v2) (set! result 1)]
        [(< v1 v2) (set! result -1)]
        [else result]))))
  result)