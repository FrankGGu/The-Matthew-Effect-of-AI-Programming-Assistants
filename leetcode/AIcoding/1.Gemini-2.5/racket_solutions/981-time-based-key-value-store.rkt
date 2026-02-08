#lang racket

(struct growable-vector (vec size) #:mutable)

(define (make-growable-vector)
  (growable-vector (make-vector 1) 0))

(define (growable-vector-add! gv item)
  (let* ((current-vec (growable-vector-vec gv))
         (current-size (growable-vector-size gv))
         (current-capacity (vector-length current-vec)))
    (if (= current-size current-capacity)
        (let* ((new-capacity (* current-capacity 2))
               (new-vec (make-vector new-capacity)))
          (for ((i (in-range current-size)))
            (vector-set! new-vec i (vector-ref current-vec i)))
          (vector-set! new-vec current-size item)
          (set-growable-vector-vec! gv new-vec)
          (set-growable-vector-size! gv (+ current-size 1)))
        (begin
          (vector-set! current-vec current-size item)
          (set-growable-vector-size! gv (+ current-size 1))))))

(define (growable-vector-ref gv index)
  (vector-ref (growable-vector-vec gv) index))

(define (growable-vector-size-ref gv)
  (growable-vector-size gv))

(define TimeMap%
  (class object%
    (init-field store)

    (define/public (set key value timestamp)
      (let ((gv (hash-ref store key #f)))
        (if gv
            (growable-vector-add! gv (cons timestamp value))
            (let ((new-gv (make-growable-vector)))
              (growable-vector-add! new-gv (cons timestamp value))
              (hash-set! store key new-gv)))))

    (define/public (get key timestamp)
      (let ((gv (hash-ref store key #f)))
        (if (not gv)
            ""
            (let ((len (growable-vector-size-ref gv)))
              (if (= len 0)
                  ""
                  (let loop ((low 0)
                             (high (- len 1))
                             (ans ""))
                    (if (> low high)
                        ans
                        (let* ((mid (+ low (quotient (- high low) 2)))
                               (pair (growable-vector-ref gv mid))
                               (t (car pair))
                               (v (cdr pair)))
                          (if (<= t timestamp)
                              (loop (+ mid 1) high v)
                              (loop low (- mid 1) ans))))))))))

    (super-new)))

(define (TimeMap)
  (new TimeMap% (store (make-hash))))