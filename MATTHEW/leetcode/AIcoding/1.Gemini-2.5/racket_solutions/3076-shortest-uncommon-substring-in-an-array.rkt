#lang racket

(require racket/string)
(require racket/set)
(require racket/hash)

(define (shortest-uncommon-substring arr)
  ;; Map each substring to a hash-set of indices of strings in 'arr' that contain it.
  (define substring-to-containing-string-indices (make-hash))

  ;; Populate the map by iterating through each string in 'arr' and its substrings
  (for ([k (in-range (length arr))]) ; k is the index of the string in arr
    (define s_k (list-ref arr k))
    (for ([i (in-range (string-length s_k))])
      (for ([j (in-range i (string-length s_k))])
        (define sub (substring s_k i (+ j 1)))
        ;; Get or create the hash-set for this substring
        (define current-set
          (hash-ref substring-to-containing-string-indices sub (make-hash-set)))
        ;; Add the current string's index 'k' to the set
        (hash-set-add! current-set k)
        ;; Update the hash table with the modified set
        (hash-set! substring-to-containing-string-indices sub current-set))))

  ;; Get all unique substrings (keys of the hash table)
  (define all-unique-substrings (hash-keys substring-to-containing-string-indices))

  ;; Sort the substrings by length (ascending) then lexicographically (ascending)
  (define sorted-substrings
    (sort all-unique-substrings
          (lambda (s1 s2)
            (let ([len1 (string-length s1)]
                  [len2 (string-length s2)])
              (cond
                ((< len1 len2) #t) ; Shorter string comes first
                ((> len1 len2) #f) ; Longer string comes later
                (else (string<? s1 s2))))))) ; Same length, compare lexicographically

  ;; Find the first uncommon substring in the sorted list
  ;; An uncommon substring is one that is contained in exactly one string from 'arr'.
  (define found-uncommon
    (for/first ([sub sorted-substrings])
      (define containing-indices-set
        (hash-ref substring-to-containing-string-indices sub))
      ;; If the substring is contained in exactly one string, it's uncommon
      (when (= (hash-set-count containing-indices-set) 1)
        sub))) ; Return this substring and stop the loop

  ;; If an uncommon substring was found, return it; otherwise, return an empty string
  (if found-uncommon
      found-uncommon
      ""))