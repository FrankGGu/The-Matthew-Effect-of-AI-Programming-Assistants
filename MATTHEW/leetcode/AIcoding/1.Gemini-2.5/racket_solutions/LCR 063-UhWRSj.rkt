#lang racket

(require racket/string)
(require racket/hash)
(require racket/list)

(struct trie-node (children is-end-of-word?))

(define (make-trie-node)
  (trie-node (make-hash) #f))

(define (trie-insert! trie-root word)
  (let loop ((node trie-root)
             (idx 0))
    (if (= idx (string-length word))
        (set-trie-node-is-end-of-word?! node #t)
        (let* ((char (stringref word idx))
               (children (trie-node-children node))
               (next-node (hash-ref children char (lambda () #f))))
          (unless next-node
            (set! next-node (make-trie-node))
            (hash-set! children char next-node))
          (loop next-node (add1 idx))))))

(define (trie-find-shortest-root trie-root word)
  (let loop ((node trie-root)
             (idx 0))
    (cond
      ((trie-node-is-end-of-word? node)
       (substring word 0 idx))
      ((= idx (string-length word))
       #f)
      (else
       (let* ((char (stringref word idx))
              (children (trie-node-children node))
              (next-node (hash-ref children char (lambda () #f))))
         (if next-node
             (loop next-node (add1 idx))
             #f))))))

(define (replace-words dictionary sentence)
  (define trie-root (make-trie-node))

  (for-each (lambda (root) (trie-insert! trie-root root)) dictionary)

  (define words-in-sentence
    (string-split sentence " "))

  (define replaced-words
    (map (lambda (word)
           (or (trie-find-shortest-root trie-root word)
               word))
         words-in-sentence))

  (string-join replaced-words " "))