#lang racket

(define (count-paths-that-can-form-a-palindrome-in-a-tree parent s)
  (define n (vector-length parent))

  ;; Build adjacency list
  (define adj (make-vector n '()))
  (for ([i (in-range 1 n)])
    (define p (vector-ref parent i))
    (vector-set! adj p (cons i (vector-ref adj p))))

  (define total-paths 0)
  (define counts (make-hash)) ; mask -> frequency
  (hash-set! counts 0 1) ; Represents the virtual parent of root, with mask 0

  (define (dfs u current-path-mask-from-root-to-parent)
    (define char-code (- (char->integer (string-ref s u)) (char->integer #\0)))
    (define char-bit (arithmetic-shift 1 char-code))
    (define current-path-mask (bitwise-xor current-path-mask-from-root-to-parent char-bit))

    ;; Count paths v-u where v is an ancestor of u (or virtual parent)
    ;; and path v-u forms a palindrome.
    ;; This means mask[v] XOR mask[u] should be 0 or (1 << k).
    ;; So, mask[v] should be mask[u] or mask[u] XOR (1 << k).

    ;; Case 1: mask[v] XOR mask[u] = 0 (i.e., mask[v] = mask[u])
    (set! total-paths (+ total-paths (hash-ref counts current-path-mask 0)))

    ;; Case 2: mask[v] XOR mask[u] = (1 << k)
    (for ([k (in-range 10)])
      (set! total-paths (+ total-paths (hash-ref counts (bitwise-xor current-path-mask (arithmetic-shift 1 k)) 0))))

    ;; Add current node's mask to counts for its descendants
    (hash-set! counts current-path-mask (+ (hash-ref counts current-path-mask 0) 1))

    ;; Recurse for children
    (for ([v (vector-ref adj u)])
      (dfs v current-path-mask))

    ;; Backtrack: remove current node's mask from counts
    (hash-set! counts current-path-mask (- (hash-ref counts current-path-mask) 1)))

  ;; Start DFS from root (node 0) with initial mask 0 (from virtual parent)
  (dfs 0 0)

  ;; Add n for single-node paths (u-u), which always form a palindrome (empty string or single character)
  (set! total-paths (+ total-paths n))

  ;; Correct for double counting:
  ;; The path from virtual parent to root (P(virtual_parent, 0)) is counted by DFS.
  ;; Its mask is mask[0] XOR 0 = mask[0]. Since mask[0] is (1 << char_at_0), it's always a palindrome.
  ;; So P(virtual_parent, 0) is always counted by the DFS.
  ;; This path P(virtual_parent, 0) is equivalent to the path 0-0.
  ;; The path 0-0 is also counted by the `total-paths += n` step.
  ;; Thus, path 0-0 is double-counted. We subtract 1 to correct this.
  (set! total-paths (- total-paths 1))

  total-paths)