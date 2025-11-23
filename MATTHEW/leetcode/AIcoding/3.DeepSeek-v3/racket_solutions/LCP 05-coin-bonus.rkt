#lang racket

(define (bonus n leadership operations)
  (define mod 1000000007)
  (define adj (make-vector (add1 n) '()))
  (define parent (make-vector (add1 n) 0))
  (define size (make-vector (add1 n) 0))
  (define coins (make-vector (add1 n) 0))
  (define in (make-vector (add1 n) 0))
  (define out (make-vector (add1 n) 0))
  (define time 0)

  (for ([edge leadership])
    (let ([u (car edge)]
          [v (cadr edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! parent v u)))

  (define (dfs u)
    (set! time (add1 time))
    (vector-set! in u time)
    (vector-set! size u 1)
    (for ([v (vector-ref adj u)])
      (dfs v)
      (vector-set! size u (+ (vector-ref size u) (vector-ref size v))))
    (vector-set! out u time))

  (dfs 1)

  (define tree (make-vector (add1 (* 2 n)) 0))
  (define lazy (make-vector (add1 (* 2 n)) 0))

  (define (push-down node l r)
    (when (> (vector-ref lazy node) 0)
      (let ([mid (quotient (+ l r) 2)])
        (vector-set! tree node (modulo (+ (vector-ref tree node) (* (vector-ref lazy node) (- r l -1))) mod)
        (when (not (= l r))
          (vector-set! lazy (* 2 node) (modulo (+ (vector-ref lazy (* 2 node)) (vector-ref lazy node)) mod)
          (vector-set! lazy (+ (* 2 node) 1) (modulo (+ (vector-ref lazy (+ (* 2 node) 1)) (vector-ref lazy node)) mod))
          (vector-set! lazy node 0)))))

  (define (update-range node l r ul ur val)
    (push-down node l r)
    (when (or (> l ur) (< r ul))
      (void))
    (when (and (>= l ul) (<= r ur))
      (vector-set! lazy node (modulo (+ (vector-ref lazy node) val) mod))
      (push-down node l r))
    (unless (or (>= l ul) (<= r ur) (= l r))
      (let ([mid (quotient (+ l r) 2)])
        (update-range (* 2 node) l mid ul ur val)
        (update-range (+ (* 2 node) 1) (add1 mid) r ul ur val)
        (vector-set! tree node (modulo (+ (vector-ref tree (* 2 node)) (vector-ref tree (+ (* 2 node) 1))) mod)))))

  (define (query-range node l r ql qr)
    (push-down node l r)
    (if (or (> l qr) (< r ql))
        0
        (if (and (>= l ql) (<= r qr))
            (vector-ref tree node)
            (let ([mid (quotient (+ l r) 2)])
              (modulo (+ (query-range (* 2 node) l mid ql qr)
                         (query-range (+ (* 2 node) 1) (add1 mid) r ql qr))
                      mod)))))

  (define res '())
  (for ([op operations])
    (let ([type (car op)])
      (cond
        [(= type 1)
         (let ([u (cadr op)]
               [val (caddr op)])
           (update-range 1 1 n (vector-ref in u) (vector-ref in u) val))]
        [(= type 2)
         (let ([u (cadr op)]
               [val (caddr op)])
           (update-range 1 1 n (vector-ref in u) (vector-ref out u) val))]
        [(= type 3)
         (let ([u (cadr op)])
           (set! res (cons (query-range 1 1 n (vector-ref in u) (vector-ref out u)) res))])))
  (reverse res))