(define (divide dividend divisor)
  (define MAX-INT (sub1 (expt 2 31)))
  (define MIN-INT (expt -2 31)))

  (if (and (= dividend MIN-INT) (= divisor -1))
      MAX-INT
      (let ()
        (define is-negative (xor (< dividend 0) (< divisor 0)))

        (define ldividend (abs dividend))
        (define ldivisor (abs divisor))

        (define result 0)
        (when (>= ldividend ldivisor)
          (let loop ((current-ldividend ldividend)
                     (current-result 0))
            (define (inner-loop temp-ldivisor temp-count)
              (cond
                ((and (>= current-ldividend (arithmetic-shift temp-ldivisor 1))
                      (not (zero? (arithmetic-shift temp-ldivisor 1))))
                 (inner-loop (arithmetic-shift temp-ldivisor 1) (arithmetic-shift temp-count 1)))
                (else
                 (let* ((new-ldividend (- current-ldividend temp-ldivisor))
                        (new-current-result (+ current-result temp-count)))
                   (if (>= new-ldividend ldivisor)
                       (loop new-ldividend new-current-result)
                       new-current-result)))))
            (set! result (inner-loop ldivisor 1))))

        (define final-result (if is-negative (- result) result))

        (cond
          ((> final-result MAX-INT) MAX-INT)
          ((< final-result MIN-INT) MIN-INT)
          (else final-result)))))