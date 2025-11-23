(define (make-NumberContainers)
  (let ((number-to-index (make-hash))
        (index-to-number (make-hash)))
    (define (put index number)
      (hash-set! index-to-number index number)
      (if (hash-has-key? number-to-index number)
          (let ((indices (hash-ref number-to-index number)))
            (hash-set! number-to-index number (set-add indices index)))
          (hash-set! number-to-index number (set index))))
    (define (get index)
      (if (hash-has-key? index-to-number index)
          (hash-ref index-to-number index)
          -1))
    (define (find-smallest number)
      (if (hash-has-key? number-to-index number)
          (let ((indices (hash-ref number-to-index number)))
            (if (set-empty? indices)
                -1
                (set-first indices)))
          -1))
    (define (print-all)
      (printf "number-to-index: ~a\n" number-to-index)
      (printf "index-to-number: ~a\n" index-to-number))
    (define (dispatch method . args)
      (case method
        [(put) (apply put args)]
        [(get) (apply get args)]
        [(find) (apply find-smallest args)]
        [(print) (print-all)]
        [else (error "Invalid method: " method)]))
    dispatch))