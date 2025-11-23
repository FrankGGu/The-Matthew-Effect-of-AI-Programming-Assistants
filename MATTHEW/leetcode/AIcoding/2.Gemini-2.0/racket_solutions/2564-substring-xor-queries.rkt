(define (substring-xor-queries s queries)
  (let* ((n (string-length s))
         (memo (make-hash))
         (result (make-vector (length queries) '(-1 -1))))
    (define (find-substring target)
      (if (hash-has-key? memo target)
          (hash-ref memo target)
          (let loop ((i 0))
            (cond
              ((= i n) #f)
              (else
               (let loop2 ((j i))
                 (cond
                   ((= j n) (loop (+ i 1)))
                   (else
                    (let* ((sub (substring s i (+ j 1)))
                           (val (string->number sub 2 #f)))
                      (cond
                        ((not val) (loop2 (+ j 1)))
                        ((= val target)
                         (hash-set! memo target (list i j))
                         (list i j))
                        ((> val target) (loop2 (+ j 1)))
                        (else (loop2 (+ j 1)))))))))))))

    (for/vector ((i (in-range (length queries))))
      (let* ((query (vector-ref queries i))
             (target (vector-ref query 0))
             (res (find-substring target)))
        (if res
            (vector-set! result i (list (car res) (cadr res)))
            #f)))
    result))