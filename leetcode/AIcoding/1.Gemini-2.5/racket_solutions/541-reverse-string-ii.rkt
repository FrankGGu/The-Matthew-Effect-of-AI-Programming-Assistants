#lang racket

(define (reverse-str s k)
  (let* ((len (string-length s))
         (char-vec (list->vector (string->list s))))

    (define (reverse-sub-vector! vec start end)
      (let loop ((l start) (r (- end 1)))
        (when (< l r)
          (let ((temp (vector-ref vec l)))
            (vector-set! vec l (vector-ref vec r))
            (vector-set! vec r temp))
          (loop (+ l 1) (- r 1)))))

    (let loop ((i 0))
      (when (< i len)
        (let* ((remaining (- len i))
               (end-of-k-block (+ i k)))
          (cond
            ((< remaining k)
             (reverse-sub-vector! char-vec i len))
            (else
             (reverse-sub-vector! char-vec i end-of-k-block))))
        (loop (+ i (* 2 k)))))

    (list->string (vector->list char-vec))))