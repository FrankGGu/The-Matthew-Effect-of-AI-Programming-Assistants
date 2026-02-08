(define top-voted-candidate%
  (class object%
    (super-new)
    (init-field persons times)

    (define (binary-search times target)
      (let loop ([left 0] [right (sub1 (vector-length times))])
        (if (> left right)
            right
            (let* ([mid (quotient (+ left right) 2]
                   [mid-val (vector-ref times mid)])
              (cond
                [(= mid-val target) mid]
                [(< mid-val target) (loop (add1 mid) right)]
                [else (loop left (sub1 mid))])))))

    (define winners (make-vector (vector-length times) 0))
    (define count (make-hash))
    (define max-count 0)
    (define current-winner -1)

    (for ([i (in-range (vector-length times))])
      (let ([person (vector-ref persons i)])
        (hash-update! count person add1 0)
        (when (>= (hash-ref count person) max-count)
          (set! max-count (hash-ref count person))
          (set! current-winner person))
        (vector-set! winners i current-winner)))

    (define/public (q t)
      (let ([idx (binary-search times t)])
        (if (>= idx 0)
            (vector-ref winners idx)
            -1)))))

(define (make-top-voted-candidate persons times)
  (new top-voted-candidate% [persons (list->vector persons)] [times (list->vector times)]))

(define top-voted-candidate (make-top-voted-candidate '() '()))

(define (online-election persons times qs)
  (set! top-voted-candidate (make-top-voted-candidate persons times))
  (map (lambda (t) (send top-voted-candidate q t)) qs))