(define (kth-largest-level-sum root k)
  (define (level-sums root)
    (let loop ([queue (list root)] [sums '()])
      (if (empty? queue)
          (reverse sums)
          (let* ([level-sum (foldl + 0 (map (λ (n) (cond [(null? n) 0] [else (car n)])) queue))]
                 [next-level (append* (map (λ (n) (cond [(null? n) '()] [else (cdr n)])) queue))])
            (loop (filter (λ (x) (not (null? x))) next-level) (cons level-sum sums))))))

  (define sums (level-sums (list root)))
  (if (< k (length sums))
      (list-ref (sort sums >) (- k 1))
      -1))