(define (find-lex-smallest-string s a b)
  (let* ([n (string-length s)]
         [visited (make-hash)]
         [min-s s])
    (define (dfs current)
      (hash-set! visited current #t)
      (when (string<? current min-s)
        (set! min-s current))
      (let* ([rotated (string-append (substring current (- n b) n) (substring current 0 (- n b)))]
             [new-current (if (hash-has-key? visited rotated) #f rotated)])
        (when new-current
          (dfs new-current))
        (for ([i (in-range 1 n 2)])
          (let* ([digit (- (char->integer (string-ref current i)) (char->integer #\0))]
                 [new-digit (modulo (+ digit a) 10)]
                 [new-char (integer->char (+ new-digit (char->integer #\0)))]
                 [new-str (string-copy current)]
                 [new-str (string-set! new-str i new-char)]
                 [new-str current])
            (when (not (hash-has-key? visited new-str))
              (dfs new-str))))))
    (dfs s)
    min-s))