(define (count-similar-strings strs)
  (define (make-key s)
    (let loop ((chars (string->list s))
               (mask 0))
      (cond
        [(null? chars) mask]
        [else
         (loop (cdr chars)
               (bitwise-ior mask (bitwise-shift-left 1 (- (char->integer (car chars)) (char->integer #\a)))))])))

  (define keys (map make-key strs))
  (define counts (make-hash))

  (for ((key keys))
    (hash-set! counts key (1+ (hash-ref counts key 0))))

  (apply + (map (lambda (x) (if (> x 1) (/ (* x (- x 1)) 2) 0)) (hash-values counts))))

(define (countPairs strs)
  (count-similar-strings strs))