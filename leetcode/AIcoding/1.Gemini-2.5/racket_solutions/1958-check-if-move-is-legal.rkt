(define (check-if-move-is-legal board rMove cMove)
  (define (is-legal-for-color board r c player-char)
    (define opponent-char (if (char=? player-char #\B) #\W #\B))
    (define dr '(-1 -1 -1 0 0 1 1 1))
    (define dc '(-1 0 1 -1 1 -1 0 1))

    (define (in-bounds? r c)
      (and (>= r 0) (< r 8) (>= c 0) (< c 8)))

    (let loop-directions ((i 0))
      (if (= i 8)
          #f
          (let* ((curr-dr (list-ref dr i))
                 (curr-dc (list-ref dc i)))
            (let check-line ((curr-r (+ r curr-dr))
                             (curr-c (+ c curr-dc))
                             (opponent-pieces-found 0))
              (if (not (in-bounds? curr-r curr-c))
                  (loop-directions (+ i 1))
                  (let ((current-square-char (list-ref (list-ref board curr-r) curr-c)))
                    (cond
                      ((char=? current-square-char opponent-char)
                       (check-line (+ curr-r curr-dr)
                                   (+ curr-c curr-dc)
                                   (+ opponent-pieces-found 1)))
                      ((char=? current-square-char player-char)
                       (if (> opponent-pieces-found 0)
                           #t
                           (loop-directions (+ i 1))))
                      (else
                       (loop-directions (+ i 1)))))))))))

  (if (not (char=? (list-ref (list-ref board rMove) cMove) #\.))
      #f
      (or (is-legal-for-color board rMove cMove #\B)
          (is-legal-for-color board rMove cMove #\W))))