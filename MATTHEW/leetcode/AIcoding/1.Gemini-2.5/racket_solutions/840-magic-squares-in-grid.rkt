#lang racket
(require racket/list)

(define (is-magic-square? square)
  (let* ([a (car (car square))]
         [b (cadr (car square))]
         [c (caddr (car square))]
         [d (car (cadr square))]
         [e (cadr (cadr square))]
         [f (caddr (cadr square))]
         [g (car (caddr square))]
         [h (cadr (caddr square))]
         [i (caddr (caddr square))]
         [nums (list a b c d e f g h i)])
    (and
     (= e 5)
     (and (andmap (lambda (x) (and (>= x 1) (<= x 9))) nums)
          (= (length (remove-duplicates nums)) 9))
     (= (+ a b c) 15)
     (= (+ d e f) 15)
     (= (+ g h i) 15)
     (= (+ a d g) 15)
     (= (+ b e h) 15)
     (= (+ c f i) 15)
     (= (+ a e i) 15)
     (= (+ c e g) 15))))

(define (num-magic-squares-in-grid grid)
  (let* ([rows (length grid)]
         [cols (if (null? grid) 0 (length (car grid)))])
    (if (or (< rows 3) (< cols 3))
        0
        (for/sum ([r (in-range 0 (- rows 2))]
                  [c (in-range 0 (- cols 2))])
          (let* ([s1 (list-ref grid r)]
                 [s2 (list-ref grid (+ r 1))]
                 [s3 (list-ref grid (+ r 2))]
                 [subgrid (list (list (list-ref s1 c) (list-ref s1 (+ c 1)) (list-ref s1 (+ c 2)))
                                (list (list-ref s2 c) (list-ref s2 (+ c 1)) (list-ref s2 (+ c 2)))
                                (list (list-ref s3 c) (list-ref s3 (+ c 1)) (list-ref s3 (+ c 2))))])
            (if (is-magic-square? subgrid) 1 0))))))