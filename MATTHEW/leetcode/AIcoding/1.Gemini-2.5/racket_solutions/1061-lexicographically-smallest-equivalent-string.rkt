(define (smallest-equivalent-string s1 s2 s3)
  (define parent (make-vector 26 0))

  ; Initialize DSU: each character is its own parent
  (for ([i (in-range 26)])
    (vector-set! parent i i))

  ; Find function with path compression
  (define (find char-code)
    (if (= (vector-ref parent char-code) char-code)
        char-code
        (let ([root (find (vector-ref parent char-code))])
          (vector-set! parent char-code root)
          root)))

  ; Union function
  (define (union char-code1 char-code2)
    (let ([root1 (find char-code1)]
          [root2 (find char-code2)])
      (unless (= root1 root2)
        (vector-set! parent root2 root1))))

  ; Process s1 and s2 to build equivalence classes
  (for ([c1 (in-string s1)]
        [c2 (in-string s2)])
    (union (- (char->integer c1) (char->integer #\a))
           (- (char->integer c2) (char->integer #\a))))

  ; Determine the lexicographically smallest character for each equivalence class
  (define min-char-for-root (make-vector 26 -1))

  (for ([i (in-range 26)])
    (let* ([char-code i]
           [root (find char-code)])
      (when (= (vector-ref min-char-for-root root) -1)
        (vector-set! min-char-for-root root char-code))))

  ; Build the result string
  (list->string
   (for/list ([original-char (in-string s3)])
     (let* ([original-char-code (- (char->integer original-char) (char->integer #\a))]
            [root (find original-char-code)]
            [smallest-equivalent-char-code (vector-ref min-char-for-root root)])
       (integer->char (+ (char->integer #\a) smallest-equivalent-char-code))))))