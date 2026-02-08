#lang racket

(define (longest-increasing-path matrix)
  (let* ([rows (if (vector? matrix) (vector-length matrix) 0)]
         [cols (if (and (vector? matrix) (> rows 0)) (vector-length (vector-ref matrix 0)) 0)])

    (if (or (= rows 0) (= cols 0))
        0
        (let* ([memo (build-vector rows (lambda (i) (build-vector cols (lambda (j) 0))))]
               [max-overall-len 0]
               [directions '((0 1) (0 -1) (1 0) (-1 0))])

          (define (dfs r c)
            (let ([cached-val (vector-ref (vector-ref memo r) c)])
              (if (> cached-val 0)
                  cached-val
                  (let ([current-val (vector-ref (vector-ref matrix r) c)]
                        [current-max-len 1])

                    (for-each (lambda (dir)
                                (let* ([dr (car dir)]
                                       [dc (cadr dir)]
                                       [nr (+ r dr)]
                                       [nc (+ c dc)])
                                  (when (and (>= nr 0) (< nr rows)
                                             (>= nc 0) (< nc cols)
                                             (> (vector-ref (vector-ref matrix nr) nc) current-val))
                                    (set! current-max-len (max current-max-len (add1 (dfs nr nc)))))))
                              directions)
                    (vector-set! (vector-ref memo r) c current-max-len)
                    current-max-len))))

          (for ([r (in-range rows)])
            (for ([c (in-range cols)])
              (set! max-overall-len (max max-overall-len (dfs r c)))))

          max-overall-len))))