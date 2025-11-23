#lang racket

(struct queue (front back) #:mutable)

(define (make-queue)
  (queue '() '()))

(define (queue-empty? q)
  (and (null? (queue-front q)) (null? (queue-back q))))

(define (queue-push! q item)
  (set-queue-back! q (cons item (queue-back q))))

(define (queue-pop! q)
  (when (null? (queue-front q))
    (set-queue-front! q (reverse (queue-back q)))
    (set-queue-back! q '()))
  (let ((item (car (queue-front q))))
    (set-queue-front! q (cdr (queue-front q)))
    item))

(define (minimum-moves grid)
  (define n (length grid))

  (define (valid-and-empty r c)
    (and (>= r 0) (< r n)
         (>= c 0) (< c n)
         (= (list-ref (list-ref grid r) c) 0)))

  (define initial-state (list 0 0 0)) ; (r c orientation), 0 for horizontal, 1 for vertical
  (define target-state (list (- n 1) (- n 2) 0)) ; Target: bottom-right, horizontal

  (call/cc
   (lambda (return)
     (define q (make-queue))
     (queue-push! q (list initial-state 0)) ; (list state moves)

     (define visited (make-hash equal?)) ; Use equal? for list comparison
     (hash-set! visited initial-state #t)

     (let bfs-loop ()
       (if (queue-empty? q)
           (return -1) ; Target not reachable
           (let* ((current-item (queue-pop! q))
                  (current-state (car current-item))
                  (current-moves (cadr current-item))
                  (r (list-ref current-state 0))
                  (c (list-ref current-state 1))
                  (orientation (list-ref current-state 2)))

             (when (equal? current-state target-state)
               (return current-moves))

             (let ((next-states '()))
               ;; 1. Move Right
               ;; If horizontal (r,c), (r,c+1) -> (r,c+1), (r,c+2)
               ;;   Requires (r,c+2) to be empty.
               ;; If vertical (r,c), (r+1,c) -> (r,c+1), (r+1,c+1)
               ;;   Requires (r,c+1) and (r+1,c+1) to be empty.
               (cond
                 ((= orientation 0) ; Horizontal
                  (when (valid-and-empty r (+ c 2))
                    (set! next-states (cons (list r (+ c 1) 0) next-states))))
                 ((= orientation 1) ; Vertical
                  (when (and (valid-and-empty r (+ c 1))
                             (valid-and-empty (+ r 1) (+ c 1)))
                    (set! next-states (cons (list r (+ c 1) 1) next-states)))))

               ;; 2. Move Down
               ;; If horizontal (r,c), (r,c+1) -> (r+1,c), (r+1,c+1)
               ;;   Requires (r+1,c) and (r+1,c+1) to be empty.
               ;; If vertical (r,c), (r+1,c) -> (r+1,c), (r+2,c)
               ;;   Requires (r+2,c) to be empty.
               (cond
                 ((= orientation 0) ; Horizontal
                  (when (and (valid-and-empty (+ r 1) c)
                             (valid-and-empty (+ r 1) (+ c 1)))
                    (set! next-states (cons (list (+ r 1) c 0) next-states))))
                 ((= orientation 1) ; Vertical
                  (when (valid-and-empty (+ r 2) c)
                    (set! next-states (cons (list (+ r 1) c 1) next-states)))))

               ;; 3. Rotate Clockwise (Horizontal to Vertical)
               ;; From (r,c), (r,c+1) to (r,c), (r+1,c)
               ;;   Requires (r+1,c) and (r+1,c+1) to be empty.
               (when (= orientation 0)
                 (when (and (valid-and-empty (+ r 1) c)
                            (valid-and-empty (+ r 1) (+ c 1)))
                   (set! next-states (cons (list r c 1) next-states))))

               ;; 4. Rotate Counter-Clockwise (Vertical to Horizontal)
               ;; From (r,c), (r+1,c) to (r,c), (r,c+1)
               ;;   Requires (r,c+1) and (r+1,c+1) to be empty.
               (when (= orientation 1)
                 (when (and (valid-and-empty r (+ c 1))
                            (valid-and-empty (+ r 1) (+ c 1)))
                   (set! next-states (cons (list r c 0) next-states))))

               (for-each (lambda (next-state)
                           (when (not (hash-has-key? visited next-state))
                             (hash-set! visited next-state #t)
                             (queue-push! q (list next-state (+ current-moves 1)))))
                         next-states)
               (bfs-loop)))))))