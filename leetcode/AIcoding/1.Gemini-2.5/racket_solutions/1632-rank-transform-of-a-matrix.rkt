#lang racket

(define (matrix-rank-transform matrix)
  (define m (vector-length matrix))
  (define n (vector-length (vector-ref matrix 0)))

  (define all-elements '())
  (for ([r (in-range m)])
    (for ([c (in-range n)])
      (set! all-elements (cons (list (vector-ref (vector-ref matrix r) c) r c) all-elements))))
  (set! all-elements (sort all-elements (lambda (a b) (< (car a) (car b)))))

  (define (group-elements elements)
    (define groups '())
    (define current-group '())
    (define current-val #f)

    (for ([elem elements])
      (let ([val (car elem)])
        (if (or (not current-val) (= val current-val))
            (begin
              (set! current-group (cons elem current-group))
              (set! current-val val))
            (begin
              (set! groups (cons (reverse current-group) groups))
              (set! current-group (list elem))
              (set! current-val val)))))
    (if (not (empty? current-group))
        (set! groups (cons (reverse current-group) groups)))
    (reverse groups))

  (define grouped-elements (group-elements all-elements))

  (define ans (build-vector m (lambda (i) (make-vector n 0))))
  (define row-max-rank (make-vector m 0))
  (define col-max-rank (make-vector n 0))

  (define (make-dsu num-elements)
    (define parents (make-vector num-elements))
    (define ranks (make-vector num-elements 1))
    (for ([i (in-range num-elements)]) (vector-set! parents i i))

    (define (find i)
      (let ([p (vector-ref parents i)])
        (if (= p i)
            i
            (let ([root (find p)])
              (vector-set! parents i root)
              root))))

    (define (union i j)
      (let ([root-i (find i)]
            [root-j (find j)])
        (unless (= root-i root-j)
          (let ([rank-i (vector-ref ranks root-i)]
                [rank-j (vector-ref ranks root-j)])
            (cond
              [(> rank-i rank-j) (vector-set! parents root-j root-i)]
              [(< rank-i rank-j) (vector-set! parents root-i root-j)]
              [else
               (vector-set! parents root-j root-i)
               (vector-set! ranks root-i (+ rank-i 1))]))
          #t)))
    (list find union))

  (for ([group grouped-elements])
    (define num-group-elements (length group))
    (define-values (find union) (make-dsu num-group-elements))

    (define row-map (make-hash))
    (define col-map (make-hash))

    (for ([j (in-range num-group-elements)])
      (define elem (list-ref group j))
      (define r (list-ref elem 1))
      (define c (list-ref elem 2))

      (when (hash-has-key? row-map r)
        (union j (hash-ref row-map r)))
      (hash-set! row-map r j)

      (when (hash-has-key? col-map c)
        (union j (hash-ref col-map c)))
      (hash-set! col-map c j))

    (define component-max-prev-ranks (make-hash))

    (for ([j (in-range num-group-elements)])
      (define elem (list-ref group j))
      (define r (list-ref elem 1))
      (define c (list-ref elem 2))
      (define root (find j))
      (define current-max-prev-rank (hash-ref component-max-prev-ranks root 0))
      (hash-set! component-max-prev-ranks root
                 (max current-max-prev-rank
                      (vector-ref row-max-rank r)
                      (vector-ref col-max-rank c))))

    (for ([j (in-range num-group-elements)])
      (define elem (list-ref group j))
      (define r (list-ref elem 1))
      (define c (list-ref elem 2))
      (define root (find j))
      (define current-rank (+ (hash-ref component-max-prev-ranks root) 1))

      (vector-set! (vector-ref ans r) c current-rank)
      (vector-set! row-max-rank r current-rank)
      (vector-set! col-max-rank c current-rank)))

  ans)