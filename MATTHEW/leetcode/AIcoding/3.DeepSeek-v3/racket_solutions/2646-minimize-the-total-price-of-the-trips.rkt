#lang racket

(define/contract (minimum-total-price n edges price trips)
  (-> exact-integer? (listof (listof exact-integer?)) (listof exact-integer?) (listof (listof exact-integer?)) exact-integer?)
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (first edge)]
          [v (second edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define cnt (make-vector n 0))
  (define (dfs u parent end path)
    (if (= u end)
        (begin
          (for ([node path])
            (vector-set! cnt node (add1 (vector-ref cnt node))))
          #t)
        (for ([v (vector-ref adj u)] #:when (not (= v parent)))
          (if (dfs v u end (cons u path))
              #t
              #f))))

  (for ([trip trips])
    (let ([start (first trip)]
          [end (second trip)])
      (dfs start -1 end '())))

  (define memo (make-hash))
  (define (dp u parent)
    (define key (cons u parent))
    (if (hash-has-key? memo key)
        (hash-ref memo key)
        (let* ([full (* (vector-ref cnt u) (list-ref price u))]
               [half (quotient full 2)]
               [no-half full])
          (for ([v (vector-ref adj u)] #:when (not (= v parent)))
            (let ([res (dp v u)])
              (set! no-half (+ no-half (car res)))
              (set! half (+ half (cdr res)))))
          (let ([res (cons (min no-half half) no-half)])
            (hash-set! memo key res)
            res))))

  (let ([res (dp 0 -1)])
    (min (car res) (cdr res))))