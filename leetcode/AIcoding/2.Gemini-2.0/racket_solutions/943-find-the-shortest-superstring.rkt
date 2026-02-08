(define (shortest-superstring a)
  (define n (length a))
  (define (overlap s1 s2)
    (let loop ((i 1))
      (cond
        ((> i (min (string-length s1) (string-length s2))) 0)
        ((string=? (substring s1 (- (string-length s1) i) (string-length s1)) (substring s2 0 i)) i)
        (else (loop (+ i 1))))))

  (define (merge s1 s2)
    (let ((o (overlap s1 s2)))
      (string-append s1 (substring s2 o (string-length s2)))))

  (define (tsp mask current-str used memo)
    (if (= used (expt 2 n))
        current-str
        (hash-ref! memo (list mask current-str)
                   (lambda ()
                     (let loop ((i 0) (shortest #f))
                       (cond
                         ((= i n) shortest)
                         ((bitwise-bit-set? mask i) (loop (+ i 1) shortest))
                         (else
                          (let ((new-mask (bitwise-ior mask (expt 2 i)))
                                (new-str (merge current-str (list-ref a i))))
                            (let ((result (tsp new-mask new-str (bitwise-ior used (expt 2 i)) memo)))
                              (if (or (not shortest) (< (string-length result) (string-length shortest)))
                                  (loop (+ i 1) result)
                                  (loop (+ i 1) shortest)))))))))))

  (define (solve)
    (let ((memo (make-hash)))
      (let loop ((i 0) (shortest #f))
        (cond
          ((= i n) shortest)
          (else
           (let ((result (tsp (expt 2 i) (list-ref a i) (expt 2 i) memo)))
             (if (or (not shortest) (< (string-length result) (string-length shortest)))
                 (loop (+ i 1) result)
                 (loop (+ i 1) shortest))))))))

  (solve))