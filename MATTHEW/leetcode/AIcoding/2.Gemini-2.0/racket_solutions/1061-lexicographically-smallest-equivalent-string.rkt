(define (smallest-equivalent-string s1 s2 base-str)
  (define (find parent i)
    (if (equal? (list-ref parent i) i)
        i
        (let ((root (find parent (list-ref parent i))))
          (vector-set! parent i root)
          root)))

  (define (union parent rank i j)
    (let ((root-i (find parent i))
          (root-j (find parent j)))
      (if (not (equal? root-i root-j))
          (if (< (list-ref rank root-i) (list-ref rank root-j))
              (vector-set! parent root-i root-j)
              (if (> (list-ref rank root-i) (list-ref rank root-j))
                  (vector-set! parent root-j root-i)
                  (begin
                    (vector-set! parent root-j root-i)
                    (list-set! rank root-i (+ 1 (list-ref rank root-i)))))))))

  (let* ((n (string-length s1))
         (parent (vector 26))
         (rank (list->vector (make-list 26 0))))

    (for ((i (in-range 26)))
      (vector-set! parent i i))

    (for ((i (in-range n)))
      (let ((u (- (char->integer (string-ref s1 i)) (char->integer #\a)))
            (v (- (char->integer (string-ref s2 i)) (char->integer #\a))))
        (union parent rank u v)))

    (list->string
     (map (lambda (c)
            (integer->char (+ (char->integer #\a) (find parent (- (char->integer c) (char->integer #\a))))))
          (string->list base-str)))))