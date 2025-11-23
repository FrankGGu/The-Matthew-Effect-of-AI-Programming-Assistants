#lang racket

(require racket/struct
         racket/vector
         racket/list)

(define-struct node (max-len prefix-len prefix-char suffix-len suffix-char total-len))

(define (merge left-node right-node)
  (define left-max-len (node-max-len left-node))
  (define left-prefix-len (node-prefix-len left-node))
  (define left-prefix-char (node-prefix-char left-node))
  (define left-suffix-len (node-suffix-len left-node))
  (define left-suffix-char (node-suffix-char left-node))
  (define left-total-len (node-total-len left-node))

  (define right-max-len (node-max-len right-node))
  (define right-prefix-len (node-prefix-len right-node))
  (define right-prefix-char (node-prefix-char right-node))
  (define right-suffix-len (node-suffix-len right-node))
  (define right-suffix-char (node-suffix-char right-node))
  (define right-total-len (node-total-len right-node))

  ; Calculate new max-len
  (define new-max-len (max left-max-len right-max-len))
  (when (char=? left-suffix-char right-prefix-char)
    (set! new-max-len (max new-max-len (+ left-suffix-len right-prefix-len))))

  ; Calculate new prefix-len and prefix-char
  (define new-prefix-char left-prefix-char)
  (define new-prefix-len left-prefix-len)
  (when (and (= new-prefix-len left-total-len) (char=? new-prefix-char right-prefix-char))
    (set! new-prefix-len (+ new-prefix-len right-prefix-len)))

  ; Calculate new suffix-len and suffix-char
  (define new-suffix-char right-suffix-char)
  (define new-suffix-len right-suffix-len)
  (when (and (= new-suffix-len right-total-len) (char=? new-suffix-char left-suffix-char))
    (set! new-suffix-len (+ new-suffix-len left-suffix-len)))

  ; Calculate new total-len
  (define new-total-len (+ left-total-len right-total-len))

  ; Return the new merged node
  (node new-max-len new-prefix-len new-prefix-char new-suffix-len new-suffix-char new-total-len))

(define (build tree initial-s tree-idx low high)
  (if (= low high)
      ; Leaf node: a single character segment
      (let ((char (string-ref initial-s low)))
        (vector-set! tree tree-idx (node 1 1 char 1 char 1)))
      ; Internal node: recurse for children and merge
      (let* ((mid (quotient (+ low high) 2))
             (left-child (* 2 tree-idx))
             (right-child (+ (* 2 tree-idx) 1)))
        (build tree initial-s left-child low mid)
        (build tree initial-s right-child (+ mid 1) high)
        (vector-set! tree tree-idx (merge (vector-ref tree left-child) (vector-ref tree right-child))))))

(define (update tree target-idx new-char tree-idx low high)
  (if (= low high)
      ; Leaf node: update its character
      (vector-set! tree tree-idx (node 1 1 new-char 1 new-char 1))
      ; Internal node: recurse to find the leaf, then merge children
      (let* ((mid (quotient (+ low high) 2))
             (left-child (* 2 tree-idx))
             (right-child (+ (* 2 tree-idx) 1)))
        (if (<= target-idx mid)
            (update tree target-idx new-char left-child low mid)
            (update tree target-idx new-char right-child (+ mid 1) high))
        (vector-set! tree tree-idx (merge (vector-ref tree left-child) (vector-ref tree right-child))))))

(define (longest-substring-of-one-repeating-character s queryCharacters queryIndices)
  (define n (string-length s))
  (when (= n 0) (list)) ; Handle empty string case

  ; Initialize segment tree. A size of 4*N is a common safe upper bound for a 1-indexed tree.
  (define tree (make-vector (* 4 n)))

  ; Build the initial segment tree from the string s.
  (build tree s 1 0 (- n 1))

  ; Process each update and collect the result.
  (define k (string-length queryCharacters)) ; Number of updates
  (define results (make-list-builder))

  (for ([i (in-range k)])
    (let ((idx (vector-ref queryIndices i))
          (char (string-ref queryCharacters i)))
      ; Perform the update
      (update tree idx char 1 0 (- n 1))
      ; After each update, the answer is the max-len of the root node (tree-idx 1)
      (add-to-list-builder results (node-max-len (vector-ref tree 1)))))

  ; Convert the list-builder to a final list of results.
  (list-builder-get-list results))