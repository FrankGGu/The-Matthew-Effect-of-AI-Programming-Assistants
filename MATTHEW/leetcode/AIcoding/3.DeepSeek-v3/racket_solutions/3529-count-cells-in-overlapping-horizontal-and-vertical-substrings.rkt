#lang racket

(define (count-overlapping-cells grid)
  (let* ([rows (length grid)]
         [cols (if (null? grid) 0 (length (car grid)))]
         [horizontal (make-hash)]
         [vertical (make-hash)]
         [count 0])

    ; Process horizontal substrings
    (for ([row (in-range rows)])
      (let ([current-row (list-ref grid row)])
        (for ([start (in-range cols)])
          (for ([end (in-range start cols)])
            (let ([sub (take (drop current-row start) (- end start -1))])
              (when (valid-substring? sub)
                (for ([col (in-range start (add1 end))])
                  (hash-set! horizontal (cons row col) #t)))))))

    ; Process vertical substrings
    (for ([col (in-range cols)])
      (for ([start (in-range rows)])
        (for ([end (in-range start rows)])
          (let ([sub (for/list ([row (in-range start (add1 end))])
                       (list-ref (list-ref grid row) col))])
            (when (valid-substring? sub)
              (for ([row (in-range start (add1 end))])
                (hash-set! vertical (cons row col) #t)))))))

    ; Count overlapping cells
    (for ([(key _) (in-hash horizontal)])
      (when (hash-has-key? vertical key)
        (set! count (add1 count))))

    count))

(define (valid-substring? sub)
  ; Placeholder for actual validation logic
  #t)