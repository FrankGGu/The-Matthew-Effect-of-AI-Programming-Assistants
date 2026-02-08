(define (cracking-the-safe n k)
  (define (power base exp)
    (if (= exp 0)
        1
        (* base (power base (- exp 1)))))

  (define num-nodes (if (= n 1) 1 (power k (- n 1))))
  ; Each node represents a prefix of length n-1.
  ; Node 0 represents "00...0" (n-1 zeros).
  ; For n=1, there's effectively one node (the empty prefix, or 0-length string).

  ; adj is a vector of lists. Each list `(vector-ref adj i)` contains the
  ; digits (0 to k-1) that can be appended to the prefix `i` to form an edge.
  ; We initialize with digits 0 to k-1 to ensure lexicographical traversal.
  (define adj (make-vector num-nodes))
  (for ([i (in-range num-nodes)])
    (vector-set! adj i (build-list k (lambda (j) j)))) ; [0, 1, ..., k-1]

  (define result '()) ; Stores the sequence of edge labels (digits) in reverse order.

  ; DFS function for finding Eulerian path
  ; current-node: integer representing the (n-1)-digit prefix
  (define (dfs current-node)
    ; Keep exploring as long as there are unvisited outgoing edges from current-node
    (let loop ()
      (let ([remaining-edges (vector-ref adj current-node)])
        (when (not (empty? remaining-edges))
          (let* ([digit (car remaining-edges)]
                 [next-adj (cdr remaining-edges)])
            (vector-set! adj current-node next-adj) ; "Remove" the edge by updating the list

            ; Calculate the next node (next prefix)
            ; current-node is p_1 p_2 ... p_{n-1} (base k integer)
            ; next-node is p_2 ... p_{n-1} digit (base k integer)
            (define next-node
              (if (= n 1)
                  0 ; For n=1, there's only one node (0-length prefix), always stays 0.
                  (+ (* (remainder current-node (power k (- n 2))) k) digit)))

            (dfs next-node) ; Recurse on the next node
            (set! result (cons digit result)) ; Add digit to the front of result (post-order traversal)
            (loop)))))) ; Continue exploring other edges from current-node if any remain

  ; Start DFS from node 0 (representing "00...0" of length n-1)
  (dfs 0)

  ; The result list contains the k^n edge labels in reverse order.
  ; We need to reverse it and then prepend the initial (n-1) zeros.
  (define final-sequence (list->string (map (lambda (d) (integer->char (+ (char->integer #\0) d))) (reverse result))))

  ; Prepend the initial (n-1) zeros
  (define initial-prefix (make-string (- n 1) #\0))

  (string-append initial-prefix final-sequence))