(define (countSubarrays nums minK maxK)
  (define (count valid)
    (if (null? valid)
        0
        (let loop ((count 0) (length 0) (lst valid))
          (cond
            ((null? lst) count)
            (else (loop (+ count (+ length 1)) (+ length 1) (cdr lst)))))))

  (define (split-subarrays lst)
    (if (null? lst)
        '()
        (let ((first (car lst)))
          (if (and (<= minK first) (<= first maxK))
              (cons first (split-subarrays (cdr lst)))
              (cons '() (split-subarrays (cdr lst)))))))

  (define valid-subarrays (split-subarrays nums))
  (apply + (map count valid-subarrays)))