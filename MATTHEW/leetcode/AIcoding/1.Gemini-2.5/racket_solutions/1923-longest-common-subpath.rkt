#lang racket

(define P1 100003)
(define M1 1000000007) ; A large prime modulus
(define P2 100019)
(define M2 1000000009) ; Another large prime modulus

(define (power-mod base exp mod)
  (let loop ((b base) (e exp) (res 1))
    (cond
      ((zero? e) res)
      ((odd? e) (loop (modulo (* b b) mod) (quotient e 2) (modulo (* res b) mod)))
      (else (loop (modulo (* b b) mod) (quotient e 2) res)))))

(define (get-subpath-hashes path L P1 M1 P2 M2)
  (let* ((n (vector-length path))
         (hashes (make-hash))
         ;; Precompute P^(L-1) mod M for efficient rolling hash updates
         (p1-pow-L-1 (power-mod P1 (- L 1) M1))
         (p2-pow-L-1 (power-mod P2 (- L 1) M2)))

    ;; L is guaranteed to be >= 1 and L <= n here by the binary search logic.
    ;; Calculate the initial hash for the first subpath (path[0...L-1])
    (let loop-init ((i 0) (h1 0) (h2 0))
      (if (< i L)
          (let ((val (vector-ref path i)))
            (loop-init (+ i 1)
                       (modulo (+ (* h1 P1) val) M1)
                       (modulo (+ (* h2 P2) val) M2)))
          (begin
            ;; Store the hash pair for the first subpath
            (hash-set! hashes (cons h1 h2) #t)
            ;; Use rolling hash to calculate hashes for subsequent subpaths
            (let loop-roll ((i 1) (current-h1 h1) (current-h2 h2))
              (when (<= (+ i L) n) ; Check if there's a subpath of length L starting at index i
                (let* ((old-val (vector-ref path (- i 1))) ; Value leaving the window
                       (new-val (vector-ref path (+ i L -1))) ; Value entering the window
                       ;; Update hash1: remove old_val, shift, add new_val
                       (next-h1 (modulo (+ (* (- current-h1 (* old-val p1-pow-L-1)) P1) new-val) M1))
                       ;; Update hash2 similarly
                       (next-h2 (modulo (+ (* (- current-h2 (* old-val p2-pow-L-1)) P2) new-val) M2)))
                  ;; Ensure hash values are positive
                  (set! next-h1 (if (< next-h1 0) (+ next-h1 M1) next-h1))
                  (set! next-h2 (if (< next-h2 0) (+ next-h2 M2) next-h2))
                  ;; Store the new hash pair
                  (hash-set! hashes (cons next-h1 next-h2) #t)
                  ;; Continue to the next subpath
                  (loop-roll (+ i 1) next-h1 next-h2)))))))
    hashes))

(define (check L paths-vecs)
  (if (zero? L)
      #t ; A subpath of length 0 always exists
      (let* ((num-paths (vector-length paths-vecs))
             ;; Get all subpath hashes for the first path
             (first-path-hashes (get-subpath-hashes (vector-ref paths-vecs 0) L P1 M1 P2 M2)))

        ;; Iterate through the remaining paths, intersecting the sets of hashes
        (let loop-paths ((k 1) (common-hashes first-path-hashes))
          (cond
            ((hash-empty? common-hashes) #f) ; If no common hashes remain, no common subpath
            ((= k num-paths) #t) ; All paths checked, common hashes still exist
            (else
             (let* ((current-path (vector-ref paths-vecs k))
                    ;; Get subpath hashes for the current path
                    (current-path-hashes (get-subpath-hashes current-path L P1 M1 P2 M2))
                    (next-common-hashes (make-hash)))
               ;; Find intersection: hashes present in 'common-hashes' and 'current-path-hashes'
               (hash-for-each
                (lambda (pair _)
                  (when (hash-has-key? current-path-hashes pair)
                    (hash-set! next-common-hashes pair #t)))
                common-hashes)
               ;; Continue with the intersected set of hashes
               (loop-paths (+ k 1) next-common-hashes))))))))

(define (longest-common-subpath paths)
  (let* ((num-paths (length paths))
         ;; Convert input lists to vectors for O(1) element access, which is crucial for performance
         (paths-vecs (map list->vector paths)))

    ;; Handle the edge case of a single path: the longest common subpath is the path itself
    (when (= num-paths 1)
      (if (empty? (car paths)) 0 (length (car paths))))

    (let* (;; The maximum possible length for a common subpath is the length of the shortest path
           (min-len (apply min (map vector-length paths-vecs)))
           (low 0) ; Minimum possible length for a common subpath
           (high min-len) ; Maximum possible length for a common subpath
           (ans 0)) ; Stores the current best answer

      ;; Perform binary search on the possible lengths of the common subpath
      (let loop-binary-search ((l low) (h high) (current-ans ans))
        (if (> l h)
            current-ans ; Binary search complete, return the best answer found
            (let* ((mid (quotient (+ l h) 2)))
              (if (check mid paths-vecs)
                  ;; If a common subpath of length 'mid' exists, try for a longer one
                  (loop-binary-search (+ mid 1) h mid)
                  ;; If not, try for a shorter one
                  (loop-binary-search l (- mid 1) current-ans))))))))