#lang racket

(require racket/queue)
(require racket/set)

(define (swap-chars s i j)
  (let* ([chars (string->list s)]
         [char-i (list-ref chars i)]
         [char-j (list-ref chars j)])
    (list->string
     (for/list ([k (in-range (length chars))])
       (cond
         [(= k i) char-j]
         [(= k j) char-i]
         [else (list-ref chars k)])))))

(define (k-similar-strings A B)
  (let* ([N (string-length A)]
         [q (make-queue)]
         [visited (make-set string=?)]
         )

    (queue-add! q (cons A 0))
    (set-add! visited A)

    (let bfs-loop ()
      (let* ([current-pair (queue-remove! q)]
             [current-s (car current-pair)]
             [steps (cdr current-pair)])

        (if (string=? current-s B)
            steps
            (begin
              (let ([i (for/first ([idx (in-range N)]
                                   #:when (not (char=? (string-ref current-s idx) (string-ref B idx))))
                           idx)]
                    )
                (for ([j (in-range (+ i 1) N)])
                  (when (char=? (string-ref current-s j) (string-ref B i))
                    (let ([next-s (swap-chars current-s i j)])
                      (when (not (set-member? visited next-s))
                        (set-add! visited next-s)
                        (queue-add! q (cons next-s (+ steps 1))))))))
              (bfs-loop)))))))