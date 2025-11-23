(define (count-increasing-paths grid)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define directions '((0 1) (1 0) (0 -1) (-1 0)))
  (define memo (make-vector rows (lambda () (make-vector cols -1))))

  (define (dfs r c prev)
    (if (or (< r 0) (>= r rows) (< c 0) (>= c cols) (<= (vector-ref (vector-ref grid r) c) prev))
        0
        (if (not (= (vector-ref (vector-ref memo r) c) -1))
            (vector-ref (vector-ref memo r) c)
            (begin
              (define count 1)
              (for-each
                (lambda (dir)
                  (let ((new-r (+ r (car dir)))
                        (new-c (+ c (cadr dir))))
                    (set! count (+ count (dfs new-r new-c (vector-ref (vector-ref grid r) c))))))
                directions)
              (vector-set! (vector-ref memo r) c count)
              count))))

  (define total-paths 0)
  (for ((r (in-range rows)))
    (for ((c (in-range cols)))
      (set! total-paths (+ total-paths (dfs r c -1)))))
  (modulo total-paths (expt 10 9))
)

(count-increasing-paths '((1 1) (3 4) (3 4) (3 4)))