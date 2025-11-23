#lang racket

(define (light-reflection grid start-row start-col start-dir)
  (define rows (length grid))
  (define cols (if (> rows 0) (string-length (car grid)) 0))

  (define (in-bounds? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define dx (list 0 1 0 -1)) ; Direction deltas for columns: 0:Up, 1:Right, 2:Down, 3:Left
  (define dy (list -1 0 1 0)) ; Direction deltas for rows: 0:Up, 1:Right, 2:Down, 3:Left

  (define (get-char r c)
    (char-nth (list-ref grid r) c))

  (define (update-direction current-dir mirror-type)
    (case mirror-type
      [#\/ (case current-dir
             [0 1] ; Up (0) -> Right (1)
             [1 0] ; Right (1) -> Up (0)
             [2 3] ; Down (2) -> Left (3)
             [3 2] ; Left (3) -> Down (2)
             [else current-dir])]
      [#\\ (case current-dir
             [0 3] ; Up (0) -> Left (3)
             [1 2] ; Right (1) -> Down (2)
             [2 1] ; Down (2) -> Right (1)
             [3 0] ; Left (3) -> Up (0)
             [else current-dir])]
      [else current-dir]))

  (let loop ((r start-row) (c start-col) (dir start-dir))
    (let* ((next-r (+ r (list-ref dy dir)))
           (next-c (+ c (list-ref dx dir))))
      (if (not (in-bounds? next-r next-c))
          (list r c)
          (let* ((cell-content (get-char next-r next-c))
                 (new-dir (update-direction dir cell-content)))
            (loop next-r next-c new-dir))))))