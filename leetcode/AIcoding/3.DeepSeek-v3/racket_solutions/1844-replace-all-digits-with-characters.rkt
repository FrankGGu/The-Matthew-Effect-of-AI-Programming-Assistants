(define/contract (replace-digits s)
  (-> string? string?)
  (define (shift c x)
    (integer->char (+ (char->integer c) x)))
  (list->string
   (for/list ([i (string-length s)])
     (if (odd? i)
         (shift (string-ref s (- i 1)) (- (char->integer (string-ref s i)) 48))
         (string-ref s i)))))