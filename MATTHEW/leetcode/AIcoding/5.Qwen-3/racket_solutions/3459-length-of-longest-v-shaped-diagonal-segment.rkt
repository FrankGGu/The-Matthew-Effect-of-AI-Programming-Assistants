#lang racket

(define (longest-v-diagonal-length grid)
  (define rows (length grid))
  (define cols (if (> rows 0) (length (car grid)) 0))
  (define max-len 0)
  (define (get-value r c)
    (if (and (>= r 0) (< r rows) (>= c 0) (< c cols))
        (list-ref (list-ref grid r) c)
        #f))
  (define (check-diagonal r c)
    (let loop ((dr -1) (dc 1) (len 0))
      (cond
        [(or (not (equal? (get-value (+ r dr) (+ c dc)) (get-value r c)))
             (not (equal? (get-value (- r dr) (- c dc)) (get-value r c))))
         len]
        [else
         (loop (+ dr 1) (+ dc -1) (+ len 1))])))
  (for ([r (in-range rows)])
    (for ([c (in-range cols)])
      (when (and (>= r 1) (< r (- rows 1)) (>= c 1) (< c (- cols 1)))
        (set! max-len (max max-len (check-diagonal r c))))))
  max-len)