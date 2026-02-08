(define (validUtf8 data)
  (define (check-byte byte)
    (if (>= byte 128)
        (if (>= byte 224)
            (if (>= byte 240)
                4
                3)
            2)
        1))

  (define (is-valid-sequence bytes count)
    (if (= count 0)
        #t
        (if (null? bytes)
            #f
            (let ((next-byte (car bytes)))
              (if (and (>= next-byte 128) (< next-byte 192))
                  (is-valid-sequence (cdr bytes) (- count 1))
                  #f)))))

  (define (validate-bytes bytes)
    (let loop ((remaining bytes) (expected 0))
      (cond
        ((null? remaining) (= expected 0))
        (else
          (let ((current (car remaining)))
            (let ((bytes-count (check-byte current)))
              (if (or (= bytes-count 1) (>= expected 1))
                  (loop (cdr remaining) (if (> bytes-count 1) (sub1 bytes-count) expected))
                  #f)))))))

  (validate-bytes data))