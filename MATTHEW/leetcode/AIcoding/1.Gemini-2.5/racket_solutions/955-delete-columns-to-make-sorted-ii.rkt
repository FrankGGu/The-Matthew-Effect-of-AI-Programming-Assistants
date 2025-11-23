#lang racket

(define (delete-columns-to-make-sorted-ii strs)
  (define N (length strs))
  (define L (string-length (car strs)))

  ;; If N=1, no comparisons are needed between rows. All columns can be kept.
  ;; The number of deleted columns is 0.
  ;; The rest of the logic handles this case correctly, resulting in 0 deleted columns.
  ;; E.g., for N=1, (- N 1) is 0, so loops over r (in-range (- N 1)) are empty.
  ;; `current-initial-equality-status` will be `()`, `is-valid-initial-col` will be `#t`.
  ;; `max-kept-columns` will track `L`, and `(- L L)` will be `0`.

  ;; Convert strings to list of chars for easier access
  (define chars-list
    (map (lambda (s) (string->list s)) strs))

  ;; dp[j] is a hash table: (list-of-booleans -> max-length)
  ;; The list-of-booleans represents the equality status between adjacent rows.
  ;; (list-ref equality-list r) is #t if strs[r] and strs[r+1] are still equal
  ;; based on the columns chosen for this dp entry.
  (define dp (make-vector L))

  (define max-kept-columns 0)

  (for ([j (in-range L)])
    (vector-set! dp j (make-hash))

    ;; Calculate initial equality status if column j is the first column in a subsequence
    (define current-initial-equality-status (make-list (- N 1) #t))
    (define is-valid-initial-col #t)
    (for ([r (in-range (- N 1))])
      (define char-r (list-ref (list-ref chars-list r) j))
      (define char-r+1 (list-ref (list-ref chars-list (+ r 1)) j))
      (cond
        [(char>? char-r char-r+1)
         (set! is-valid-initial-col #f)
         (break)]
        [(char<? char-r char-r+1)
         ;; If char-r < char-r+1, then strs[r] is now strictly less than strs[r+1].
         ;; So, the equality status for this pair becomes #f.
         (set! current-initial-equality-status (list-set current-initial-equality-status r #f))]
        ;; If char=? char-r char-r+1, it remains #t in current-initial-equality-status
        ))

    ;; Case 1: Column j is a valid first column in a subsequence
    (when is-valid-initial-col
      (hash-set! (vector-ref dp j) current-initial-equality-status 1)
      (set! max-kept-columns (max max-kept-columns 1)))

    ;; Case 2: Column j extends a subsequence ending at an earlier column i
    (for ([i (in-range j)])
      (define dp-i (vector-ref dp i))
      (hash-for-each
       dp-i
       (lambda (prev-equality-status prev-len)
         (define can-append #t)
         ;; new-equality-status starts as a copy of prev-equality-status.
         ;; We will modify it only if an equality state changes from #t to #f.
         (define new-equality-status prev-equality-status)

         (for ([r (in-range (- N 1))])
           ;; Only check if strs[r] and strs[r+1] were previously equal.
           ;; If they were already strictly less, they remain strictly less.
           (when (list-ref prev-equality-status r)
             (define char-r (list-ref (list-ref chars-list r) j))
             (define char-r+1 (list-ref (list-ref chars-list (+ r 1)) j))
             (cond
               [(char>? char-r char-r+1)
                ;; If adding column j makes strs[r] > strs[r+1], it's invalid.
                (set! can-append #f)
                (break)]
               [(char<? char-r char-r+1)
                ;; If adding column j makes strs[r] < strs[r+1], update equality status to #f.
                (set! new-equality-status (list-set new-equality-status r #f))]
               ;; If char=? char-r char-r+1, new-equality-status[r] remains #t (from prev-equality-status)
               )))

         (when can-append
           (define current-max-len (hash-ref (vector-ref dp j) new-equality-status 0))
           (define new-len (+ prev-len 1))
           (when (> new-len current-max-len)
             (hash-set! (vector-ref dp j) new-equality-status new-len)
             (set! max-kept-columns (max max-kept-columns new-len))))))))

  (- L max-kept-columns))