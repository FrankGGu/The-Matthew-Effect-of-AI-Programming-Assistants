#lang racket

(require racket/set)

(define (hit-bricks grid hits)
  (define rows (length grid))
 define cols (if (null? grid) 0 (length (car grid))))

  (define (index r c) (+ (* r cols) c))

  (define parent (make-vector (* rows cols) 0))
  (define size (make-vector (* rows cols) 1))

  (for ([i (in-range (* rows cols))])
    (vector-set! parent i i))

  (define (find u)
    (if (= u (vector-ref parent u))
        u
        (let ([root (find (vector-ref parent u))])
          (vector-set! parent u root)
          root)))

  (define (union u v)
    (let ([root-u (find u)]
          [root-v (find v)])
      (when (not (= root-u root-v))
        (vector-set! parent root-u root-v)
        (vector-set! size root-v (+ (vector-ref size root-v) (vector-ref size root-u))))))

  (define (is-connected u v)
    (= (find u) (find v)))

  (define (is-stable r c)
    (or (= r 0) (is-connected (index r c) (index 0 0))))

  (define (get-size r c)
    (vector-ref size (find (index r c))))

  (define (valid? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define (mark-hit grid hits)
    (for ([hit (in-list hits)])
      (let ([r (car hit)]
            [c (cadr hit)])
        (when (and (valid? r c) (= (list-ref (list-ref grid r) c) 1))
          (list-set! (list-ref grid r) c 2)))))

  (define (build-initial-union grid)
    (for ([r (in-range rows)])
      (for ([c (in-range cols)])
        (when (= (list-ref (list-ref grid r) c) 1)
          (for ([dir (in-list '((0 1) (1 0) (-1 0) (0 -1)))])
            (let ([nr (+ r (car dir))]
                  [nc (+ c (cadr dir))])
              (when (and (valid? nr nc) (= (list-ref (list-ref grid nr) nc) 1))
                (union (index r c) (index nr nc)))))))))

  (mark-hit grid hits)
  (build-initial-union grid)

  (define result '())
  (define directions '((0 1) (1 0) (-1 0) (0 -1)))

  (for ([hit (in-list (reverse hits))])
    (let ([r (car hit)]
          [c (cadr hit)])
      (if (not (valid? r c))
          (set! result (cons 0 result))
          (let ([current (list-ref (list-ref grid r) c)])
            (if (not (= current 2))
                (set! result (cons 0 result))
                (begin
                  (list-set! (list-ref grid r) c 1)
                  (let ([root (find (index r c))]
                        [prev-stable (is-stable r c)]
                        [count 0])
                    (for ([dir (in-list directions)])
                      (let ([nr (+ r (car dir))]
                            [nc (+ c (cadr dir))])
                        (when (and (valid? nr nc) (= (list-ref (list-ref grid nr) nc) 1))
                          (union (index r c) (index nr nc)))))
                    (unless prev-stable
                      (when (is-stable r c)
                        (set! count (- (get-size r c) 1))))
                    (set! result (cons count result)))))))))

  (reverse result))