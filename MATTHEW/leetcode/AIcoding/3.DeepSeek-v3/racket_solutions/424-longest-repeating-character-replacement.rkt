(define/contract (character-replacement s k)
  (-> string? exact-integer? exact-integer?)
  (let ([counts (make-hash)]
        [left 0]
        [max-count 0]
        [max-length 0])
    (for ([right (in-range (string-length s))])
      (let ([char (string-ref s right)])
        (hash-update! counts char add1 (lambda () 0))
        (set! max-count (max max-count (hash-ref counts char)))
      (when (< (- (- right left) max-count) k)
        (set! max-length (max max-length (+ (- right left) 1)))
      (when (>= (- (- right left) max-count) k)
        (let ([left-char (string-ref s left)])
          (hash-update! counts left-char sub1)
          (set! left (add1 left)))))
    max-length))