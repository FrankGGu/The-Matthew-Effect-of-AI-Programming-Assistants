#lang racket

(require data/queue)

(define (minimum-moves grid)
  (define n (length grid))
  (define target-r (- n 1))
  (define target-c (- n 2))

  (define q (make-queue))
  (define visited (make-hash))

  (define (is-valid r c)
    (and (>= r 0) (< r n)
         (>= c 0) (< c n)
         (= (list-ref (list-ref grid r) c) 0)))

  (queue-push! q (list 0 0 0 0))
  (hash-set! visited (list 0 0 0) #t)

  (call/cc
   (lambda (return)
     (let loop ()
       (when (not (queue-empty? q))
         (let* ((current-state (queue-pop! q))
                (r (list-ref current-state 0))
                (c (list-ref current-state 1))
                (orientation (list-ref current-state 2))
                (moves (list-ref current-state 3)))

           (when (and (= r target-r) (= c target-c) (= orientation 0))
             (return moves))

           (define (add-to-queue next-r next-c next-orientation)
             (let ((next-state-key (list next-r next-c next-orientation)))
               (when (not (hash-has-key? visited next-state-key))
                 (hash-set! visited next-state-key #t)
                 (queue-push! q (list next-r next-c next-orientation (+ moves 1))))))

           (cond
             ((= orientation 0) ; Horizontal: (r, c) and (r, c+1)
              ; Move Right
              (when (is-valid r (+ c 2))
                (add-to-queue r (+ c 1) 0))
              ; Move Down
              (when (and (is-valid (+ r 1) c)
                         (is-valid (+ r 1) (+ c 1)))
                (add-to-queue (+ r 1) c 0))
              ; Rotate to Vertical
              (when (and (is-valid (+ r 1) c)
                         (is-valid (+ r 1) (+ c 1)))
                (add-to-queue r c 1)))
             ((= orientation 1) ; Vertical: (r, c) and (r+1, c)
              ; Move Right
              (when (and (is-valid r (+ c 1))
                         (is-valid (+ r 1) (+ c 1)))
                (add-to-queue r (+ c 1) 1))
              ; Move Down
              (when (is-valid (+ r 2) c)
                (add-to-queue (+ r 1) c 1))
              ; Rotate to Horizontal
              (when (and (is-valid r (+ c 1))
                         (is-valid (+ r 1) (+ c 1)))
                (add-to-queue r c 0))))
           (loop))))
     -1)))