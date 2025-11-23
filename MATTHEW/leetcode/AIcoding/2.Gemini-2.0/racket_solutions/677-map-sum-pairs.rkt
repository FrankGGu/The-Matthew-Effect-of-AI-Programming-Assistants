(define map-sum-pairs
  (lambda ()
    (let ((m (make-hash)))
      (define (insert key val)
        (hash-set! m key val))
      (define (sum prefix)
        (let loop ((keys (hash-keys m)) (total 0))
          (if (null? keys)
              total
              (let ((k (car keys)))
                (if (string=? (substring k 0 (min (string-length k) (string-length prefix))) prefix)
                    (loop (cdr keys) (+ total (hash-ref m k)))
                    (loop (cdr keys) total))))))
      (define (dispatch cmd . args)
        (match cmd
          ('insert (key val) (insert key val))
          ('sum (prefix) (sum prefix))))
      dispatch)))