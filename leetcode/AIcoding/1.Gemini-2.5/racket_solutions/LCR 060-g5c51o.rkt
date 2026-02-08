(define (top-k-frequent nums k)
  ;; 1. Count frequencies of each number
  (define freq-map (make-hash))
  (for-each (lambda (num)
              (hash-set! freq-map num (+ (hash-ref freq-map num 0) 1)))
            nums)

  ;; 2. Convert the hash map to a list of (number . frequency) pairs
  (define freq-list (hash->list freq-map))

  ;; 3. Sort the list of pairs by frequency in descending order
  (define sorted-freq-list
    (sort freq-list (lambda (a b)
                      (> (cdr a) (cdr b)))))

  ;; 4. Take the first k elements and extract their numbers
  (map car (take sorted-freq-list k)))