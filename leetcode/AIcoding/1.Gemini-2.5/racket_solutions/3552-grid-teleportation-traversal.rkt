#lang racket

(require data/queue)

(define (solve grid)
  (let/ec return-result
    (define M (length grid))
    (define N (length (car grid)))

    (define (valid? r c)
      (and (>= r 0) (< r M) (>= c 0) (< c N)))

    (define start-pos #f)
    (define end-pos #f)
    (define teleporter-locations (make-hash))

    (for ([r (in-range M)])
      (for ([c (in-range N)])
        (define char (list-ref (list-ref grid r) c))
        (cond
          [(char=? char #\S) (set! start-pos (cons r c))]
          [(char=? char #\E) (set! end-pos (cons r c))]
          [(char-lower-case? char)
           (hash-update! teleporter-locations char
                         (lambda (lst) (cons (cons r c) lst))
                         '())])))

    (unless start-pos (return-result -1))
    (unless end-pos (return-result -1))

    (when (equal? start-pos end-pos)
      (return-result 0))

    (define q (make-queue))
    (define visited (make-hash))
    (define teleporter-type-used (make-hash))

    (queue-put! q (list (car start-pos) (cdr start-pos) 0))
    (hash-set! visited start-pos #t)

    (define dr '(-1 1 0 0))
    (define dc '(0 0 -1 1))

    (let bfs-loop ()
      (when (not (queue-empty? q))
        (define current (queue-get! q))
        (define r (list-ref current 0))
        (define c (list-ref current 1))
        (define dist (list-ref current 2))

        (when (and (= r (car end-pos)) (= c (cdr end-pos)))
          (return-result dist))

        (for ([i (in-range 4)])
          (define nr (+ r (list-ref dr i)))
          (define nc (+ c (list-ref dc i)))
          (when (valid? nr nc)
            (define next-char (list-ref (list-ref grid nr) nc))
            (unless (char=? next-char #\#)
              (define next-pos (cons nr nc))
              (unless (hash-has-key? visited next-pos)
                (hash-set! visited next-pos #t)
                (queue-put! q (list nr nc (+ dist 1)))))))

        (define current-char (list-ref (list-ref grid r) c))
        (when (char-lower-case? current-char)
          (unless (hash-has-key? teleporter-type-used current-char)
            (hash-set! teleporter-type-used current-char #t)
            (for ([tp-pos (in-list (hash-ref teleporter-locations current-char))])
              (unless (hash-has-key? visited tp-pos)
                (hash-set! visited tp-pos #t)
                (queue-put! q (list (car tp-pos) (cdr tp-pos) (+ dist 1)))))))
        (bfs-loop)))

    -1))