(define (get-frequency s)
  (let ([char-frequency (make-hash)])
    (for-each (lambda (c)
                (hash-set! char-frequency c (add1 (hash-ref char-frequency c 0))))
              (string->list s))
    (hash-map char-frequency (lambda (k v) (cons k v)))))

(define (get-smallest-char s)
  (if (string=? s "")
      #\z
      (apply min (string->list s))))

(define (compare-strings-by-frequency strs1 strs2)
  (let ([freq1 (map (lambda (s) (list (get-smallest-char s) (get-frequency s))) strs1)]
        [freq2 (map (lambda (s) (list (get-smallest-char s) (get-frequency s))) strs2)])
    (map (lambda (x) (equal? (cdr x) (cdr (car (filter (lambda (y) (equal? (car x) (car y))) freq2))))) freq1)))

(define (num-smaller-by-frequency e)
  (let ([freq (get-frequency e)])
    (lambda (s)
      (let ([s-freq (get-frequency s)])
        (if (equal? (car freq) (car s-freq))
            (> (cdr s-freq) (cdr freq))
            (> (car s-freq) (car freq)))))))

(define (num-smaller-by-frequency-each strs1 strs2)
  (map (lambda (s1) (length (filter (num-smaller-by-frequency s1) strs2))) strs1))