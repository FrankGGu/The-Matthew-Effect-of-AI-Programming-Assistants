(define (longest-happy-string a b c)
  (let loop ((a a) (b b) (c c) (res ""))
    (cond
      [(and (= a 0) (= b 0) (= c 0)) res]
      [else
       (let* ((next-char
                (cond
                  [(and (>= a b) (>= a c))
                   (if (and (> a 0) (not (string=? (substring res (max 0 (- (string-length res) 1)) (string-length res)) "a")))
                       "a"
                       (cond [(>= b c) (if (> b 0) "b" "c")] [else (if (> c 0) "c" "b")]))]
                  [(and (>= b a) (>= b c))
                   (if (and (> b 0) (not (string=? (substring res (max 0 (- (string-length res) 1)) (string-length res)) "b")))
                       "b"
                       (cond [(>= a c) (if (> a 0) "a" "c")] [else (if (> c 0) "c" "a")]))]
                  [else
                   (if (and (> c 0) (not (string=? (substring res (max 0 (- (string-length res) 1)) (string-length res)) "c")))
                       "c"
                       (cond [(>= a b) (if (> a 0) "a" "b")] [else (if (> b 0) "b" "a")]))]))
              (new-a (if (string=? next-char "a") (- a 1) a))
              (new-b (if (string=? next-char "b") (- b 1) b))
              (new-c (if (string=? next-char "c") (- c 1) c)))
         (if (or (and (string=? next-char "a") (= new-a a))
                 (and (string=? next-char "b") (= new-b b))
                 (and (string=? next-char "c") (= new-c c)))
             res
             (loop new-a new-b new-c (string-append res next-char))))])))