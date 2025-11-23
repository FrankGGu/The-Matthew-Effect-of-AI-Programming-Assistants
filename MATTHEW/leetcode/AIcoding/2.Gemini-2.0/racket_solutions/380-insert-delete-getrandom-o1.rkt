(define ( RandomizedSet )
  (struct rs (data idxs) #:mutable))

(define ( rs-new )
  (rs (vector) (hash)))

(define ( insert rs val )
  (if (hash-has-key? (rs-idxs rs) val)
      #f
      (begin
        (vector-push-back! (rs-data rs) val)
        (hash-set! (rs-idxs rs) val (- (vector-length (rs-data rs)) 1))
        #t)))

(define ( remove rs val )
  (if (not (hash-has-key? (rs-idxs rs) val))
      #f
      (let* ((idx (hash-ref (rs-idxs rs) val))
             (last-val (vector-ref (rs-data rs) (- (vector-length (rs-data rs)) 1))))
        (vector-set! (rs-data rs) idx last-val)
        (vector-pop-back! (rs-data rs))
        (hash-remove! (rs-idxs rs) val)
        (if (not (= val last-val))
            (hash-set! (rs-idxs rs) last-val idx)
            #void)
        #t)))

(define ( getRandom rs )
  (if (zero? (vector-length (rs-data rs)))
      #f
      (let ((rand-idx (random (vector-length (rs-data rs)))) )
        (vector-ref (rs-data rs) rand-idx))))