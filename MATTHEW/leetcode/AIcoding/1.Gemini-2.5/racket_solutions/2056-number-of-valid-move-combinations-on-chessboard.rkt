#lang racket

(require racket/set)
(require racket/for)

(define (pos-to-coords s)
  (let* ((col-char (string-ref s 0))
         (row-char (string-ref s 1))
         (col (- (char->integer col-char) (char->integer #\a)))
         (row (- (char->integer row-char) (char->integer #\1))))
    (list row col)))

(define (path-obstructed? s e initial-board)
  (let* ((sr (car s)) (sc (cadr s))
         (er (car e)) (ec (cadr e)))
    (cond
      ((= sr er)
       (let ((start-c (min sc ec))
             (end-c (max sc ec)))
         (for/or ((c (in-range (+ start-c 1) end-c)))
           (set-member? initial-board (list sr c)))))
      ((= sc ec)
       (let ((start-r (min sr er))
             (end-r (max sr er)))
         (for/or ((r (in-range (+ start-r 1) end-r)))
           (set-member? initial-board (list r sc)))))
      ((= (abs (- sr er)) (abs (- sc ec)))
       (let* ((dr (if (> er sr) 1 -1))
              (dc (if (> ec sc) 1 -1)))
         (for/or ((i (in-range 1 (abs (- sr er)))))
           (set-member? initial-board (list (+ sr (* i dr)) (+ sc (* i dc)))))))
      (else #f))))

(define (num-valid-move-combinations pieces positions)
  (define num-pieces (length pieces))

  (define initial-piece-info
    (map (lambda (p) (cons (car p) (pos-to-coords (cadr p)))) pieces))

  (define target-moves-coords
    (map (lambda (pos-list) (map pos-to-coords pos-list)) positions))

  (define initial-board-set
    (list->set (map cdr initial-piece-info)))

  (define (count-recursive piece-idx current-final-positions-set)
    (if (= piece-idx num-pieces)
        1
        (let* ((piece-type (car (list-ref initial-piece-info piece-idx)))
               (initial-pos (cdr (list-ref initial-piece-info piece-idx)))
               (possible-targets (list-ref target-moves-coords piece-idx)))
          (for/sum ((target-pos possible-targets))
            (let ((is-sliding-piece (or (string=? piece-type "rook")
                                        (string=? piece-type "queen")
                                        (string=? piece-type "bishop"))))
              (cond
                ((set-member? current-final-positions-set target-pos) 0)
                ((and is-sliding-piece
                      (not (equal? initial-pos target-pos))
                      (path-obstructed? initial-pos target-pos initial-board-set))
                 0)
                (else
                 (count-recursive
                  (+ piece-idx 1)
                  (set-add current-final-positions-set target-pos))))))))

  (count-recursive 0 (set)))