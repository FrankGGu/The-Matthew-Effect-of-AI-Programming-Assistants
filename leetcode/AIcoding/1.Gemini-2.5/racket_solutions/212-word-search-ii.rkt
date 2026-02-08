#lang racket

(struct trie-node (children word) #:mutable)

(define (trie-insert! root-node w)
  (let loop ((current-node root-node)
             (chars (string->list w)))
    (if (null? chars)
        ;; If all characters are processed, mark the current node as an end of word
        (set-trie-node-word! current-node w)
        (let* ((char (car chars))
               (children (trie-node-children current-node))
               (next-node (hash-ref children char #f)))
          ;; If the child node does not exist, create it
          (unless next-node
            (set! next-node (trie-node (make-hash) #f))
            (hash-set! children char next-node))
          ;; Continue with the next character and the next node
          (loop next-node (cdr chars))))))

(define (list-of-lists->vector-of-vectors lol)
  (define m (length lol))
  (if (zero? m)
      (vector)
      (let* ((n (length (car lol)))
             (vec-of-vec (make-vector m)))
        (for ((r (in-range m))
              (row lol))
          (let ((char-vec (make-vector n)))
            (for ((c (in-range n))
                  (char row))
              (vector-set! char-vec c char))
            (vector-set! vec-of-vec r char-vec)))
        vec-of-vec)))

(define (find-words board words)
  (define m (length board))
  ;; Handle empty board or empty rows
  (when (zero? m) (hash-set->list (make-hash-set)))
  (define n (length (car board)))
  (when (zero? n) (hash-set->list (make-hash-set)))

  ;; Convert the input board to a mutable vector of vectors
  (define mutable-board (list-of-lists->vector-of-vectors board))

  ;; Build the Trie from the list of words
  (define root (trie-node (make-hash) #f))
  (for-each (lambda (word) (trie-insert! root word)) words)

  ;; A hash set to store unique found words
  (define found-words (make-hash-set))

  ;; Depth-First Search (DFS) function
  (define (dfs r c node)
    ;; Check if current coordinates are within board boundaries
    (when (and (>= r 0) (< r m) (>= c 0) (< c n))
      (let* ((current-char (vector-ref (vector-ref mutable-board r) c)))
        ;; If the cell has been visited (marked with #\0), skip
        (when (char=? current-char #\0)
          (void)) ; Do nothing, already visited
        (let* ((children (trie-node-children node))
               (next-node (hash-ref children current-char #f)))
          ;; If there's a valid path in the Trie for current-char
          (when next-node
            ;; If this node marks the end of a word, add it to the found set
            (when (trie-node-word next-node)
              (hash-set-add! found-words (trie-node-word next-node))
              ;; Optimization: Mark the word as found in the Trie by setting its word field to #f.
              ;; This prevents adding the same word multiple times if found via different paths
              ;; and prunes further searches for *this specific word* from this node.
              (set-trie-node-word! next-node #f))

            ;; Mark the current cell as visited by changing its character to a special marker (#\0)
            (vector-set! (vector-ref mutable-board r) c #\0)

            ;; Explore all four adjacent neighbors
            (dfs (+ r 1) c next-node) ; Down
            (dfs (- r 1) c next-node) ; Up
            (dfs r (+ c 1) next-node) ; Right
            (dfs r (- c 1) next-node) ; Left

            ;; Backtrack: restore the cell's original character
            (vector-set! (vector-ref mutable-board r) c current-char))))))

  ;; Iterate through each cell of the board to start a DFS traversal
  (for* ((r (in-range m))
         (c (in-range n)))
    (dfs r c root))

  ;; Convert the hash set of found words to a list and return
  (hash-set->list found-words))