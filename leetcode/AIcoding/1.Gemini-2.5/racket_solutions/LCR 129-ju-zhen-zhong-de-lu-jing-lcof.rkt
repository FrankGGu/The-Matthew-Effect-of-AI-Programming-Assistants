#lang racket

(define (exist board word)
  (define m (length board))
  (define n (length (car board)))

  (define board-vec (make-vector m))
  (for ([i (in-range m)])
    (vector-set! board-vec i (list->vector (list-ref board i))))

  (define word-chars (string->list word))
  (define word-len (length word-chars))

  (define (dfs r c k)
    (cond
      [(= k word-len) #t]
      [(or (< r 0) (>= r m) (< c 0) (>= c n)) #f]
      [(! (char=? (vector-ref (vector-ref board-vec r) c) (list-ref word-chars k))) #f]
      [else
       (define original-char (vector-ref (vector-ref board-vec r) c))
       (vector-set! (vector-ref board-vec r) c #\*)

       (define found
         (or (dfs (+ r 1) c (+ k 1))
             (dfs (- r 1) c (+ k 1))
             (dfs r (+ c 1) (+ k 1))
             (dfs r (- c 1) (+ k 1))))

       (vector-set! (vector-ref board-vec r) c original-char)
       found]))

  (let loop ([r 0])
    (cond
      [(= r m) #f]
      [else
       (let loop-inner ([c 0])
         (cond
           [(= c n) (loop (+ r 1))]
           [(dfs r c 0) #t]
           [else (loop-inner (+ c 1))]))]))