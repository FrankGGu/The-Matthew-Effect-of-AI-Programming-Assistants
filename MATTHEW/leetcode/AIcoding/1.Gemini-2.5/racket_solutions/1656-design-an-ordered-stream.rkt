(define-struct ordered-stream (buffer ptr n))

(define (OrderedStream n)
  (make-ordered-stream (make-vector n #f) 1 n))

(define (insert os idKey value)
  (let* ((buffer (ordered-stream-buffer os))
         (n (ordered-stream-n os)))
    (vector-set! buffer (- idKey 1) value)
    (let loop ((current-ptr (ordered-stream-ptr os))
               (collected-values '()))
      (if (and (<= current-ptr n) (vector-ref buffer (- current-ptr 1)))
          (loop (+ current-ptr 1)
                (cons (vector-ref buffer (- current-ptr 1)) collected-values))
          (begin
            (set-ordered-stream-ptr! os current-ptr)
            (reverse collected-values))))))