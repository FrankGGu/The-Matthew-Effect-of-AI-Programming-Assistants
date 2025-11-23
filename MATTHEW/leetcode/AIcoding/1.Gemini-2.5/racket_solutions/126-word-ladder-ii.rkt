(require racket/hash)
(require racket/set)
(require racket/queue)

(define (find-ladders beginWord endWord wordList)
  (define valid-words (list->set wordList))

  ; Add endWord to `valid-words` if it's not already present.
  ; This ensures `get-neighbors` can find it as a potential next word.
  (unless (set-member? valid-words endWord)
    (set! valid-words (set-add valid-words endWord)))

  ; Create a copy of `valid-words` for neighbor generation.
  ; `beginWord` itself cannot be an intermediate transformed word.
  ; If `beginWord` is in the original `wordList`, we remove it from this set
  ; to prevent `get-neighbors` from considering it as a valid step.
  (define original-valid-words-for-neighbors (set-copy valid-words))
  (when (set-member? original-valid-words-for-neighbors beginWord)
    (set! original-valid-words-for-neighbors (set-remove original-valid-words-for-neighbors beginWord)))

  ; Helper function to find all words that are one edit distance away
  ; and are present in the `original-valid-words-for-neighbors` set.
  (define (get-neighbors word)
    (define len (string-length word))
    (define neighbors '())
    (for ([i (in-range len)])
      (define prefix (substring word 0 i))
      (define suffix (substring word (+ i 1) len))
      (for ([c-val (in-range (char->integer #\a) (add1 (char->integer #\z)))])
        (define char-c (integer->char c-val))
        (when (char-not-equal? char-c (string-ref word i))
          (define new-word (string-append prefix (string char-c) suffix))
          (when (set-member? original-valid-words-for-neighbors new-word)
            (set! neighbors (cons new-word neighbors))))))
    neighbors)

  ; `dist`: Hash table to store the shortest distance from `beginWord` to each word.
  (define dist (make-hash))
  ; `parents`: Hash table to store a list of predecessor words for each word
  ; that lead to it via a shortest path.
  (define parents (make-hash))

  ; `q`: Queue for words to be processed at the current BFS level.
  (define q (make-queue))
  ; `next-q`: Queue for words to be processed at the next BFS level.
  (define next-q (make-queue))

  ; Initialize BFS: beginWord is at distance 0.
  (hash-set! dist beginWord 0)
  (queue-put! q beginWord)

  ; `found-end-min-dist`: Flag to indicate if `endWord` has been reached
  ; at its shortest possible distance.
  (define found-end-min-dist #f)
  ; `min-dist-to-end`: Stores the shortest distance to `endWord`.
  (define min-dist-to-end +inf.0)

  ; BFS loop to find shortest distances and build parent relationships.
  (let bfs-loop ((level 0))
    ; Continue as long as there are words to process at the current level,
    ; and `endWord` hasn't been found at its shortest distance yet.
    (unless (or (queue-empty? q) found-end-min-dist)
      (set! next-q (make-queue)) ; Reset `next-q` for the new level

      ; Process all words in the current level's queue.
      (let process-current-level ()
        (unless (queue-empty? q)
          (define w (queue-get! q))

          ; Find neighbors for the current word `w`.
          (for ([n (get-neighbors w)])
            ; If `n` has not been visited yet (no distance recorded).
            (when (not (hash-has-key? dist n))
              (hash-set! dist n (add1 level)) ; Set its distance.
              (hash-set! parents n (list w))  ; Set `w` as its first parent.
              (queue-put! next-q n))          ; Add `n` to the next level's queue.
            ; If `n` has been visited and is reachable at the current level + 1.
            ; This means `w` is another valid parent for `n` on a shortest path.
            (when (= (hash-ref dist n) (add1 level))
              (hash-set! parents n (cons w (hash-ref parents n '()))))

            ; If `endWord` is found, set the flag and record its shortest distance.
            (when (string=? n endWord)
              (set! found-end-min-dist #t)
              (set! min-dist-to-end (add1 level))))
          (process-current-level)))

      ; Move words from `next-q` to `q` for the next iteration (next level).
      (set! q next-q)
      (bfs-loop (add1 level))))

  ; If `endWord` was never reached during BFS, set `min-dist-to-end` to -1
  ; to indicate no path exists.
  (unless (hash-has-key? dist endWord)
    (set! min-dist-to-end -1))

  ; `all-paths`: List to store all found shortest transformation sequences.
  (define all-paths '())

  ; DFS function to reconstruct all shortest paths using the `parents` map.
  ; It builds paths in reverse (from `endWord` to `beginWord`) and then reverses them.
  (define (dfs current-word current-path)
    (define new-path (cons current-word current-path)) ; Prepend current word to path

    ; If `beginWord` is reached, a full path is found.
    (when (string=? current-word beginWord)
      ; Only add paths that match the shortest length found by BFS.
      (when (= (length new-path) (add1 min-dist-to-end))
        (set! all-paths (cons new-path all-paths)))
      (void)) ; Return from DFS for this branch

    ; Recursively call DFS for each parent of the `current-word`.
    (when (hash-has-key? parents current-word)
      (for ([p (hash-ref parents current-word)])
        (dfs p new-path))))

  ; Start DFS from `endWord` if a path was found.
  (when (hash-has-key? dist endWord)
    (dfs endWord '()))

  all-paths)