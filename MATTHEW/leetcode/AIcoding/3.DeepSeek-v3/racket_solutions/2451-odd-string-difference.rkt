(define/contract (odd-string words)
  (-> (listof string?) string?)
  (let* ([diff-list (lambda (s)
                      (for/list ([i (in-range 1 (string-length s))])
                        (- (char->integer (string-ref s i)) (char->integer (string-ref s (- i 1))))))]
         [diffs (map diff-list words)]
         [freq (make-hash)])
    (for ([d diffs] [word words])
      (hash-update! freq d (lambda (v) (cons word v)) '()))
    (let ([res (findf (lambda (k) (= 1 (length (hash-ref freq k))))) (hash-keys freq))])
      (car (hash-ref freq res)))))