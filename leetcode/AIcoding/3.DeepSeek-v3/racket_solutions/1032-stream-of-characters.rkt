(define trie%
  (class object%
    (super-new)
    (init-field)
    (field [children (make-hash)])
    (field [is-end #f])

    (define/public (insert word)
      (let loop ([node this] [i (sub1 (string-length word))])
        (when (>= i 0)
          (let ([c (string-ref word i)])
            (unless (hash-has-key? (get-field children node) c)
              (hash-set! (get-field children node) c (new trie%)))
            (loop (hash-ref (get-field children node) c) (sub1 i)))))
      (set-field! is-end this #t))

    (define/public (search stream-char)
      (let loop ([node this] [i 0])
        (if (get-field is-end node)
            #t
            (if (>= i (vector-length stream-char))
                #f
                (let ([c (vector-ref stream-char i)])
                  (if (hash-has-key? (get-field children node) c)
                      (loop (hash-ref (get-field children node) c) (add1 i))
                      #f))))))))

(define stream-of-characters%
  (class object%
    (super-new)
    (init-field words)
    (field [root (new trie%)]
           [stream (make-vector 40000 #\nul)]
           [ptr 0])

    (for ([word (in-list words)])
      (send root insert word))

    (define/public (query letter)
      (vector-set! stream ptr letter)
      (set! ptr (add1 ptr))
      (send root search (vector-copy stream 0 ptr)))))

(define (make-stream-characters words)
  (new stream-of-characters% [words words]))