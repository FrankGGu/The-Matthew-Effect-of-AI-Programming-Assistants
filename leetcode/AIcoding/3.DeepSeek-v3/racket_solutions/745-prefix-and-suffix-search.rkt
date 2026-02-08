(define (make-word-filter words)
  (let ((prefix-hash (make-hash))
        (suffix-hash (make-hash)))
    (for ([(word idx) (in-indexed words)])
      (for ([i (in-range (add1 (string-length word)))])
        (let ((prefix (substring word 0 i)))
          (hash-update! prefix-hash prefix 
                        (lambda (lst) (cons idx lst)) 
                        '())))
      (for ([i (in-range (add1 (string-length word)))])
        (let ((suffix (substring word (- (string-length word) i)))))
          (hash-update! suffix-hash suffix 
                        (lambda (lst) (cons idx lst)) 
                        '()))))
    (lambda (prefix suffix)
      (let ((prefix-ids (hash-ref prefix-hash prefix '()))
            (suffix-ids (hash-ref suffix-hash suffix '())))
        (let loop ((p prefix-ids) 
                  (s suffix-ids) 
                  (max-idx -1))
          (cond 
            [(or (null? p) (null? s)) max-idx]
            [(= (car p) (car s)) (loop (cdr p) (cdr s) (max max-idx (car p)))]
            [(< (car p) (car s)) (loop (cdr p) s max-idx)]
            [else (loop p (cdr s) max-idx)])))))

(define word-filter (make-word-filter '("apple")))