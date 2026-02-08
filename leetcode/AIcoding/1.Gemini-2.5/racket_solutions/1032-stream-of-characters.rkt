#lang racket

(define (make-trie-node)
  (hash 'children (make-hash) 'is-word-end #f))

(define (trie-insert! root-node char-list)
  (let loop ((current-node root-node)
             (chars char-list))
    (if (empty? chars)
        ;; Mark the current node as the end of a word
        (hash-set! current-node 'is-word-end #t)
        (let* ((char (car chars))
               (children (hash-ref current-node 'children))
               (next-node (hash-ref children char #f)))
          ;; If the child node does not exist, create it
          (unless next-node
            (set! next-node (make-trie-node))
            (hash-set! children char next-node))
          ;; Continue to the next character and node
          (loop next-node (cdr chars))))))

(define StreamChecker%
  (class object%
    (init-field words) ; List of words to check against

    ;; Internal fields for the StreamChecker instance
    (define trie (make-trie-node)) ; The root of the Trie for reversed words
    (define char-stream '())       ; List of characters queried so far, most recent at head
    (define max-word-len 0)        ; Maximum length of any word in 'words'

    ;; Call the superclass constructor
    (super-new)

    ;; Constructor logic: executed when a StreamChecker object is created
    (set! max-word-len
          (if (empty? words)
              0
              (apply max (map string-length words))))

    ;; Build the Trie by inserting reversed words
    (for-each (lambda (word)
                (trie-insert! trie (reverse (string->list word))))
              words)

    ;; Public method to query the stream with a new character
    (define/public (query char)
      ;; Add the new character to the front of the stream
      (set! char-stream (cons char char-stream))

      ;; Trim the character stream to keep only the last 'max-word-len' characters
      ;; (since we only need to check suffixes up to the longest word length)
      (when (> (length char-stream) max-word-len)
        (set! char-stream (take char-stream max-word-len)))

      ;; Traverse the Trie using the current character stream to check for word matches
      (let check-stream ((current-trie-node trie)
                         (chars-to-check char-stream))
        (cond
          ((empty? chars-to-check) #f) ; No more characters to check, no word found
          (else
           (let* ((c (car chars-to-check))
                  (children (hash-ref current-trie-node 'children))
                  (next-node (hash-ref children c #f)))
             (cond
               ((not next-node) #f) ; No path in the Trie for this character, no word found
               (else
                ;; If the current node marks the end of a word, we found a match
                (if (hash-ref next-node 'is-word-end)
                    #t
                    ;; Otherwise, continue checking with the next character in the stream
                    (check-stream next-node (cdr chars-to-check)))))))))))