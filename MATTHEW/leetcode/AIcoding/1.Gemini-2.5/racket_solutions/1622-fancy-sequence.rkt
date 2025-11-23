#lang racket

(define MOD 1000000007)

(define (pow base exp mod)
  (let loop ((base base) (exp exp) (res 1))
    (cond
      ((zero? exp) res)
      ((odd? exp) (loop (modulo (* base base) mod) (quotient exp 2) (modulo (* res base) mod)))
      (else (loop (modulo (* base base) mod) (quotient exp 2) res)))))

(define (mod-inverse n mod)
  (pow n (- mod 2) mod))

(struct fancy-element (val m-app a-app) #:transparent)

(define Fancy%
  (class object%
    (field [fancy-vector (make-vector 10 #f)]
           [current-size 0]
           [m-global 1]
           [a-global 0])

    (define/public (append val)
      (when (= current-size (vector-length fancy-vector))
        (let* ((new-capacity (* 2 (vector-length fancy-vector)))
               (new-vector (make-vector new-capacity #f)))
          (vector-copy! new-vector 0 fancy-vector 0 current-size)
          (set! fancy-vector new-vector)))

      (vector-set! fancy-vector current-size (fancy-element val m-global a-global))
      (set! current-size (+ current-size 1)))

    (define/public (addAll inc)
      (set! a-global (modulo (+ a-global inc) MOD)))

    (define/public (multAll m)
      (set! m-global (modulo (* m-global m) MOD))
      (set! a-global (modulo (* a-global m) MOD)))

    (define/public (getIndex idx)
      (if (>= idx current-size)
          -1
          (let* ((elem (vector-ref fancy-vector idx))
                 (v-orig (fancy-element-val elem))
                 (m-app (fancy-element-m-app elem))
                 (a-app (fancy-element-a-app elem)))
            (if (= m-app 0)
                a-global
                (let* ((m-inv (mod-inverse m-app MOD))
                       (m-delta (modulo (* m-global m-inv) MOD))
                       (term-a-delta (modulo (* m-delta a-app) MOD))
                       (a-delta (modulo (+ (- a-global term-a-delta) MOD) MOD)))
                  (modulo (+ (modulo (* v-orig m-delta) MOD) a-delta) MOD))))))
    (super-new)))

(define (fancy)
  (new Fancy%))