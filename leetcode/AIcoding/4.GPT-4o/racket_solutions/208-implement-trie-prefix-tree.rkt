#lang racket

(struct trie-node (children is-end))

(define (make-trie-node)
  (trie-node (make-hash) #f))

(define trie
  (struct:trie ()
    (insert (word)
      (define (helper node chars)
        (cond
          [(null? chars) (set! (trie-node-is-end node) #t)]
          [else
           (define ch (car chars))
           (define next-node (hash-ref (trie-node-children node) ch 
                                        (lambda () (begin
                                                      (define new-node (make-trie-node))
                                                      (hash-set! (trie-node-children node) ch new-node)
                                                      new-node))))
           (helper next-node (cdr chars))]))
      (helper (make-trie-node) (string->list word)))

    (search (word)
      (define (helper node chars)
        (cond
          [(null? chars) (trie-node-is-end node)]
          [else
           (define ch (car chars))
           (define next-node (hash-ref (trie-node-children node) ch #f))
           (if next-node
               (helper next-node (cdr chars))
               #f)]))
      (helper (make-trie-node) (string->list word)))

    (starts-with (prefix)
      (define (helper node chars)
        (cond
          [(null? chars) #t]
          [else
           (define ch (car chars))
           (define next-node (hash-ref (trie-node-children node) ch #f))
           (if next-node
               (helper next-node (cdr chars))
               #f)]))
      (helper (make-trie-node) (string->list prefix)))))

(define my-trie (trie))