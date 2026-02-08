#lang racket

(define-struct (growable-vector) (vec size))

(define (make-gv [initial-capacity 1])
  (make-growable-vector (make-vector initial-capacity #f) 0))

(define (gv-ref gv idx)
  (vector-ref (growable-vector-vec gv) idx))

(define (gv-set! gv idx val)
  (vector-set! (growable-vector-vec gv) idx val))

(define (gv-add! gv val)
  (let* ([current-vec (growable-vector-vec gv)]
         [current-size (growable-vector-size gv)]
         [current-capacity (vector-length current-vec)])
    (when (= current-size current-capacity)
      (let* ([new-capacity (max 1 (* current-capacity 2))]
             [new-vec (make-vector new-capacity #f)])
        (for ([i (in-range current-size)])
          (vector-set! new-vec i (vector-ref current-vec i)))
        (set-growable-vector-vec! gv new-vec)))
    (vector-set! (growable-vector-vec gv) current-size val)
    (set-growable-vector-size! gv (+ current-size 1))))

(define (gv-length gv)
  (growable-vector-size gv))

(define (gv-empty? gv)
  (= (gv-length gv) 0))

(define (gv-last gv)
  (gv-ref gv (- (gv-length gv) 1)))

(define snapshot-array%
  (class object%
    (init-field [length 0])

    (field [current-snap-id (box 0)])
    (field [history (make-vector length (make-gv))])

    (define/public (set index val)
      (define current-history-at-index (vector-ref history index))
      (define current-snap (unbox current-snap-id))

      (if (and (not (gv-empty? current-history-at-index))
               (= (car (gv-last current-history-at-index)) current-snap))
          (gv-set! current-history-at-index
                   (- (gv-length current-history-at-index) 1)
                   (cons current-snap val))
          (gv-add! current-history-at-index
                   (cons current-snap val))))

    (define/public (snap)
      (define old-snap-id (unbox current-snap-id))
      (set-box! current-snap-id (+ old-snap-id 1))
      old-snap-id)

    (define/public (get index snap-id)
      (define history-at-index (vector-ref history index))

      (let loop ([low 0] [high (- (gv-length history-at-index) 1)] [ans-val 0])
        (if (> low high)
            ans-val
            (let* ([mid (quotient (+ low high) 2)]
                   [entry (gv-ref history-at-index mid)]
                   [entry-snap-id (car entry)]
                   [entry-val (cdr entry)])
              (if (<= entry-snap-id snap-id)
                  (loop (+ mid 1) high entry-val)
                  (loop low (- mid 1) ans-val))))))))