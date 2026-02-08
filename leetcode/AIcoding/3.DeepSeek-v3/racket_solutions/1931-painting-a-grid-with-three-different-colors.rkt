#lang racket

(define MOD 1000000007)

(define (color-the-grid m n)
  (define (valid? a b)
    (not (= a b)))

  (define (get-valid-colors prev-colors)
    (define prev1 (if (null? prev-colors) -1 (car prev-colors)))
    (define prev2 (if (or (null? prev-colors) (null? (cdr prev-colors))) -1 (cadr prev-colors)))
    (filter (lambda (c) (and (valid? c prev1) (valid? c prev2))) '(0 1 2)))

  (define (next-states state)
    (define colors (map (lambda (x) (modulo x 3)) state))
    (define new-colors (get-valid-colors colors))
    (for/list ([c (in-list new-colors)])
      (cons c (take state (sub1 m)))))

  (define (state->key state)
    (foldl (lambda (x res) (+ (* res 3) x)) 0 state))

  (define init-states
    (let loop ([i 0] [state '()])
      (if (= i m)
          (list state)
          (append-map (lambda (c) (loop (add1 i) (cons c state))) '(0 1 2)))))

  (define init-dp (make-hash))
  (for ([state (in-list init-states)])
    (hash-set! init-dp (state->key state) 1))

  (let loop ([i 1] [dp init-dp])
    (if (= i n)
        (modulo (apply + (hash-values dp)) MOD)
        (let ([new-dp (make-hash)])
          (for ([(key cnt) (in-hash dp)])
            (define state (for/list ([k (in-range m)])
                            (modulo (quotient key (expt 3 k)) 3)))
            (for ([new-state (in-list (next-states state))])
              (define new-key (state->key new-state))
              (hash-update! new-dp new-key (lambda (v) (modulo (+ v cnt) MOD)) 0)))
          (loop (add1 i) new-dp)))))