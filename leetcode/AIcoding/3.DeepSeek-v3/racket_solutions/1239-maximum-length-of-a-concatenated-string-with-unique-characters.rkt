(define/contract (max-length arr)
  (-> (listof string?) exact-integer?)
  (define (has-duplicates? s)
    (let loop ([chars (string->list s)] [seen (set)])
      (cond
        [(null? chars) #f]
        [(set-member? seen (car chars)) #t]
        [else (loop (cdr chars) (set-add seen (car chars)))])))

  (define (solve idx current combined)
    (cond
      [(= idx (length arr)) (string-length combined)]
      [else
       (let* ([s (list-ref arr idx)]
              [new-combined (string-append combined s)])
         (if (or (has-duplicates? s) (has-duplicates? new-combined))
             (solve (add1 idx) current combined)
             (max (solve (add1 idx) current combined)
                  (solve (add1 idx) (add1 idx) new-combined))))]))

  (solve 0 0 ""))