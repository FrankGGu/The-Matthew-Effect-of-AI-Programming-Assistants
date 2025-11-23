(define (make-word-dictionary)
  (let ((trie (make-hash)))
    (define (add-word word)
      (let loop ((node trie) (chars (string->list word)))
        (cond
          ((null? chars)
           (hash-set! node '#end #t))
          (else
           (let ((c (car chars)))
             (unless (hash-has-key? node c)
               (hash-set! node c (make-hash)))
             (loop (hash-ref node c) (cdr chars)))))))
    (define (search word)
      (define (search-helper node chars)
        (cond
          ((null? chars)
           (hash-has-key? node '#end))
          (else
           (let ((c (car chars)))
             (cond
               ((char=? c #\.)
                (let ((results (map (lambda (key)
                                       (if (char? key)
                                           (search-helper (hash-ref node key) (cdr chars))
                                           #f))
                                     (hash-keys node))))
                  (ormap identity results)))
               ((hash-has-key? node c)
                (search-helper (hash-ref node c) (cdr chars)))
               (else
                #f))))))
      (search-helper trie (string->list word)))
    (struct word-dictionary (add-word search))
    (word-dictionary add-word search)))

(define WordDictionary%
  (class object%
    (super-new)
    (define trie (make-hash))
    (define/public (add-word word)
      (let loop ((node trie) (chars (string->list word)))
        (cond
          ((null? chars)
           (hash-set! node '#end #t))
          (else
           (let ((c (car chars)))
             (unless (hash-has-key? node c)
               (hash-set! node c (make-hash)))
             (loop (hash-ref node c) (cdr chars)))))))
    (define/public (search word)
      (define (search-helper node chars)
        (cond
          ((null? chars)
           (hash-has-key? node '#end))
          (else
           (let ((c (car chars)))
             (cond
               ((char=? c #\.)
                (let ((results (map (lambda (key)
                                       (if (char? key)
                                           (search-helper (hash-ref node key) (cdr chars))
                                           #f))
                                     (hash-keys node))))
                  (ormap identity results)))
               ((hash-has-key? node c)
                (search-helper (hash-ref node c) (cdr chars)))
               (else
                #f))))))
      (search-helper trie (string->list word)))))