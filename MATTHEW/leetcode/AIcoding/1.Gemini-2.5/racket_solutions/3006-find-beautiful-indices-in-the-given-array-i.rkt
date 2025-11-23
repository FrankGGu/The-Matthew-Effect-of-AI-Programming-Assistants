(define (find-all-occurrences txt p)
  (let* ([txt-len (string-length txt)]
         [p-len (string-length p)])
    (for/list ([idx (in-range 0 (- txt-len p-len -1))]
               #:when (string=? (substring txt idx (+ idx p-len)) p))
      idx)))

(define (find-beautiful-indices s a b k)
  (let* ([indices-a (find-all-occurrences s a)]
         [indices-b (find-all-occurrences s b)]
         [n-b (length indices-b)])

    (let ([final-res '()])
      (let loop-i ([i-list indices-a]
                   [j-ptr 0])
        (when (not (empty? i-list))
          (let* ([i (car i-list)]
                 ; Advance j_ptr to the first j such that j >= i - k
                 [current-j-ptr (let loop-j-advance ([curr-ptr j-ptr])
                                  (if (and (< curr-ptr n-b)
                                           (< (list-ref indices-b curr-ptr) (- i k)))
                                      (loop-j-advance (add1 curr-ptr))
                                      curr-ptr))]
                 ; From current-j-ptr, collect all j such that j <= i + k
                 [temp-j-ptr current-j-ptr])
            (let loop-j-collect ([inner-j-ptr temp-j-ptr])
              (when (and (< inner-j-ptr n-b)
                         (<= (list-ref indices-b inner-j-ptr) (+ i k)))
                (set! final-res (cons (list i (list-ref indices-b inner-j-ptr)) final-res))
                (loop-j-collect (add1 inner-j-ptr))))
            (loop-i (cdr i-list) current-j-ptr))))
      (sort (reverse final-res) (lambda (p1 p2)
                                  (or (< (car p1) (car p2))
                                      (and (= (car p1) (car p2))
                                           (< (cadr p1) (cadr p2)))))))))