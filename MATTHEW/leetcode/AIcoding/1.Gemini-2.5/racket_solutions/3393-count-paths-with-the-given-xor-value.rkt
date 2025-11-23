(require racket/hash)

(define (count-paths-with-given-xor-value grid k)
  (define m (length grid))
  (define n (length (car grid)))

  (define total-moves (+ m n -2))
  (define mid-moves (floor (/ total-moves 2)))

  (define memo (make-hash)) ; Stores (list r c) -> (hash xor_val -> count)
  (define total-paths (box 0)) ; Mutable counter for total paths

  ; dfs1 explores paths from (0,0) for mid-moves steps.
  ; current-xor is the XOR sum of the path from (0,0) to (r,c) inclusive.
  (define (dfs1 r c current-xor steps)
    (if (= steps mid-moves)
        (begin
          (define current-map (hash-ref memo (list r c) (make-hash)))
          (hash-set! current-map current-xor (+ (hash-ref current-map current-xor 0) 1))
          (hash-set! memo (list r c) current-map))
        (begin
          (when (< (+ r 1) m) ; Move down
            (dfs1 (+ r 1) c (xor current-xor (list-ref (list-ref grid (+ r 1)) c)) (+ steps 1)))
          (when (< (+ c 1) n) ; Move right
            (dfs1 r (+ c 1) (xor current-xor (list-ref (list-ref grid r) (+ c 1))) (+ steps 1))))))

  ; dfs2 explores paths from (m-1, n-1) backwards for (total-moves - mid-moves) steps.
  ; current-xor is the XOR sum of the path from (m-1, n-1) to (r,c) inclusive.
  (define (dfs2 r c current-xor steps)
    (if (= steps (- total-moves mid-moves))
        (begin
          (when (hash-has-key? memo (list r c))
            (define current-map (hash-ref memo (list r c)))
            (hash-for-each
             current-map
             (lambda (xor1 count1)
               ; xor1: XOR sum from (0,0) to (r,c)
               ; current-xor: XOR sum from (m-1,n-1) to (r,c)
               ; grid[r][c] is included in both xor1 and current-xor.
               ; To get the total path XOR, we need to XOR grid[r][c] once more
               ; because A XOR B XOR A = B. So xor1 XOR current-xor effectively
               ; removes grid[r][c] once, leaving the XOR sum of all other cells.
               ; Thus, the full path XOR sum is (xor1 XOR current-xor XOR grid[r][c]).
               (when (= (xor xor1 current-xor (list-ref (list-ref grid r) c)) k)
                 (set-box! total-paths (+ (unbox total-paths) count1)))))))
        (begin
          (when (>= (- r 1) 0) ; Move up
            (dfs2 (- r 1) c (xor current-xor (list-ref (list-ref grid (- r 1)) c)) (+ steps 1)))
          (when (>= (- c 1) 0) ; Move left
            (dfs2 r (- c 1) (xor current-xor (list-ref (list-ref grid r) (- c 1))) (+ steps 1))))))

  ; Handle the 1x1 grid edge case separately as it has 0 moves
  (when (and (= m 1) (= n 1))
    (if (= (list-ref (list-ref grid 0) 0) k)
        (set-box! total-paths 1)
        (set-box! total-paths 0))
    (unbox total-paths))

  ; Initial calls for DFS
  ; Start dfs1 from (0,0) with its value, and 0 steps.
  (dfs1 0 0 (list-ref (list-ref grid 0) 0) 0)
  ; Start dfs2 from (m-1, n-1) with its value, and 0 steps.
  (dfs2 (- m 1) (- n 1) (list-ref (list-ref grid (- m 1)) (- n 1)) 0)

  (unbox total-paths))