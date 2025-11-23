(define (equations-possible equations)
  (let* ([num-vars 26]
         [parent (make-vector num-vars)])

    ;; Initialize DSU: each element is its own parent
    (for ([i (in-range num-vars)])
      (vector-set! parent i i))

    ;; Find operation with path compression
    (define (find i)
      (if (= (vector-ref parent i) i)
          i
          (let ([root (find (vector-ref parent i))])
            (vector-set! parent i root)
            root)))

    ;; Union operation
    (define (union-sets i j)
      (let ([root-i (find i)]
            [root-j (find j)])
        (unless (= root-i root-j)
          (vector-set! parent root-i root-j))))

    ;; First pass: process all equality equations
    (for ([eq-str (in-list equations)])
      (when (char=? (string-ref eq-str 1) #\=)
        (let* ([char1 (string-ref eq-str 0)]
               [char2 (string-ref eq-str 3)]
               [idx1 (- (char->integer char1) (char->integer #\a))]
               [idx2 (- (char->integer char2) (char->integer #\a))])
          (union-sets idx1 idx2))))

    ;; Second pass: process all inequality equations
    ;; If any inequality contradicts the established equalities, return #f
    (let loop ([remaining-equations equations])
      (cond
        [(empty? remaining-equations) #t] ; All inequalities checked, no contradiction found
        [else
         (let* ([eq-str (car remaining-equations)]
                [rest (cdr remaining-equations)])
           (if (char=? (string-ref eq-str 1) #\!)
               (let* ([char1 (string-ref eq-str 0)]
                      [char2 (string-ref eq-str 3)]
                      [idx1 (- (char->integer char1) (char->integer #\a))]
                      [idx2 (- (char->integer char2) (char->integer #\a))])
                 (if (= (find idx1) (find idx2))
                     #f ; Contradiction found: two unequal variables are in the same set
                     (loop rest)))
               (loop rest)))])))) ; Not an inequality, skip and continue