(define (count-of-atoms formula)
  (define (parse s)
    (let loop ([i 0] [stack (list (make-hash))])
      (if (>= i (string-length s))
          (car stack)
          (let ([c (string-ref s i)])
            (cond
              [(char-upper-case? c)
               (let* ([start i]
                      [i (add1 i)]
                      [i (let loop ([i i])
                           (if (and (< i (string-length s)) (char-lower-case? (string-ref s i)))
                               (loop (add1 i))
                               i))]
                      [atom (substring s start i)]
                      [i (if (and (< i (string-length s)) (char-numeric? (string-ref s i)))
                             (let loop ([i i] [num 0])
                               (if (and (< i (string-length s)) (char-numeric? (string-ref s i)))
                                   (loop (add1 i) (+ (* num 10) (- (char->integer (string-ref s i)) 48)))
                                   (begin
                                     (hash-update! (car stack) atom (lambda (v) (+ v (if (zero? num) 1 num)) 0)
                                   ))
                             (begin
                               (hash-update! (car stack) atom (lambda (v) (add1 v)) 0)
                               i))])
                 (loop i stack))]
              [(char=? c #\( )
               (loop (add1 i) (cons (make-hash) stack))]
              [(char=? c #\) )
               (let* ([i (add1 i)]
                      [i (if (and (< i (string-length s)) (char-numeric? (string-ref s i)))
                             (let loop ([i i] [num 0])
                               (if (and (< i (string-length s)) (char-numeric? (string-ref s i)))
                                   (loop (add1 i) (+ (* num 10) (- (char->integer (string-ref s i)) 48))
                                   (begin
                                     (let ([top (car stack)]
                                           [next (cadr stack)])
                                     (hash-for-each top (lambda (k v)
                                                          (hash-update! next k (lambda (old) (+ old (* v (if (zero? num) 1 num))))))
                                     i)
                                   ))
                             (begin
                               (let ([top (car stack)]
                                     [next (cadr stack)])
                                 (hash-for-each top (lambda (k v)
                                                  (hash-update! next k (lambda (old) (+ old v)))))
                               i))])
                 (loop i (cdr stack)))]))))))

  (let ([counts (parse formula)])
    (let ([sorted-keys (sort (hash-keys counts) string<?)])
      (apply string-append
             (map (lambda (k)
                    (let ([v (hash-ref counts k)])
                      (if (> v 1)
                          (string-append k (number->string v))
                          k)))
                  sorted-keys)))))