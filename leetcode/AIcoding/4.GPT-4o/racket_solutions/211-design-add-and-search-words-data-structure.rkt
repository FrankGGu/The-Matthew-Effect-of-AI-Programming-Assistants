(define WordDictionary
  (class object%
    (super-new)

    (define/public (addWord word)
      (define (insert node word)
        (if (null? word)
            (set! (send node 'is-end) #t)
            (let* ((char (string-ref word 0))
                   (next (or (hash-ref (send node 'children) char #f)
                             (let ((new-node (new node%)))
                               (hash-set! (send node 'children) char new-node)
                               new-node))))
              (insert next (substring word 1)))))
      (insert this word))

    (define/public (search word)
      (define (search-helper node word index)
        (if (= index (string-length word))
            (send node 'is-end)
            (let ((char (string-ref word index)))
              (if (char=? char #\.)
                  (or (for/or ([child (hash-values (send node 'children))])
                        (search-helper child word (+ index 1)))
                      #f)
                  (let ((next (hash-ref (send node 'children) char #f)))
                    (if next
                        (search-helper next word (+ index 1))
                        #f))))))
      (search-helper this word))

    (define/public (initialize)
      (set! (send this 'children) (make-hash))
      (set! (send this 'is-end) #f))

    (initialize)))

(define node% (class object% (super-new) (define/public (children) (make-hash)) (define/public (is-end) #f)))

(define WordDictionary (new WordDictionary))