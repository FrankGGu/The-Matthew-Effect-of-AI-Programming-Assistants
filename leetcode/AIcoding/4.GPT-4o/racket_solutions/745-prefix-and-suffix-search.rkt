(define PrefixAndSuffixSearch
  (lambda ()
    (define trie (make-vector 20000 '()))
    (define words '())

    (define (add-word word index)
      (let loop ((i 0))
        (when (< i (string-length word))
          (let ((current (string-ref word i)))
            (let ((node (vector-ref trie (char->integer current))))
              (if (equal? node '())
                  (begin
                    (vector-set! trie (char->integer current) (make-vector 256 '()))
                    (set! node (vector-ref trie (char->integer current))))
                (set! node node)))
            (loop (+ i 1)))))

    (define (search-word word)
      (let loop ((i 0))
        (if (< i (string-length word))
            (let ((current (string-ref word i)))
              (let ((node (vector-ref trie (char->integer current))))
                (if (equal? node '())
                    #f
                    (loop (+ i 1)))))
            #t)))

    (define (find-index prefix suffix)
      (for ((i (in-range (vector-length words))))
        (if (and (string-prefix? prefix (vector-ref words i))
                 (string-suffix? suffix (vector-ref words i)))
            (return i)))
      -1))

    (define (insert word)
      (set! words (vector-append words (vector word)))
      (add-word word (vector-length words)))

    (define (f prefix suffix)
      (find-index prefix suffix))

    (list insert f)))