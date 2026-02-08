(define (num-rook-captures board)
  (let* ((rows 8)
         (cols 8)
         (rook-pos (let find-rook-pos ((r 0))
                       (if (= r rows)
                           #f ; Should not happen based on problem constraints
                           (let find-rook-col ((c 0))
                             (if (= c cols)
                                 (find-rook-pos (+ r 1))
                                 (if (char=? (list-ref (list-ref board r) c) #\R)
                                     (list r c)
                                     (find-rook-col (+ c 1)))))))))
    (let ((r-row (car rook-pos))
          (r-col (cadr rook-pos)))
      (let loop-directions ((dr-list '(-1 1 0 0)) ; Delta row for up, down, left, right
                            (dc-list '(0 0 -1 1)) ; Delta col for up, down, left, right
                            (captures 0))
        (if (empty? dr-list)
            captures
            (let* ((dr (car dr-list))
                   (dc (car dc-list)))
              (let check-path ((curr-row (+ r-row dr))
                               (curr-col (+ r-col dc)))
                (if (or (< curr-row 0) (>= curr-row rows)
                        (< curr-col 0) (>= curr-col cols))
                    (loop-directions (cdr dr-list) (cdr dc-list) captures) ; Out of bounds, stop for this direction
                    (let ((square-char (list-ref (list-ref board curr-row) curr-col)))
                      (cond
                        ((char=? square-char #\p)
                         (loop-directions (cdr dr-list) (cdr dc-list) (+ captures 1))) ; Pawn found, capture and stop
                        ((char=? square-char #\B)
                         (loop-directions (cdr dr-list) (cdr dc-list) captures)) ; Bishop found, blocked, stop
                        (else
                         (check-path (+ curr-row dr) (+ curr-col dc)))))))))))))