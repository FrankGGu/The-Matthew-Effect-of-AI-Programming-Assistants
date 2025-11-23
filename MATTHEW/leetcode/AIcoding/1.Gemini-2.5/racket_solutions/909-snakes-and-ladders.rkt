#lang racket
(require racket/queue)
(require racket/hash)

(define (get-coords s N)
  (define s0 (- s 1))
  (define row-from-bottom (quotient s0 N))
  (define col-in-row (remainder s0 N))

  (define r (- N 1 row-from-bottom))
  (define c (if (even? row-from-bottom)
                col-in-row
                (- N 1 col-in-row)))
  (list r c))

(define (snakes-and-ladders board)
  (define N (length board))
  (define target (* N N))

  (define q (make-queue))
  (queue-put! q (list 1 0))

  (define visited (make-hash))
  (hash-set! visited 1 #t)

  (let loop ()
    (if (queue-empty? q)
        -1
        (let* ((current-state (queue-get! q))
               (current-square (car current-state))
               (current-moves (cadr current-state)))

          (if (= current-square target)
              current-moves
              (begin
                (for ([i (in-range 1 7)])
                  (let* ((next-s (+ current-square i)))
                    (when (<= next-s target)
                      (let* ((coords (get-coords next-s N))
                             (r (car coords))
                             (c (cadr coords))
                             (board-val (list-ref (list-ref board r) c))
                             (actual-next-s (if (= board-val -1) next-s board-val)))

                        (unless (hash-has-key? visited actual-next-s)
                          (hash-set! visited actual-next-s #t)
                          (queue-put! q (list actual-next-s (+ current-moves 1))))))))
                (loop)))))))