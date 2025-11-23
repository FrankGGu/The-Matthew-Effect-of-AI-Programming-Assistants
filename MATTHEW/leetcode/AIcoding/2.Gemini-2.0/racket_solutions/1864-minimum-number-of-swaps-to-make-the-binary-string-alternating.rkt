(define (min-swaps s)
  (define (count-swaps s target)
    (let loop ([i 0] [swaps 0] [s-list (string->list s)])
      (cond
        [(= i (string-length s)) swaps]
        [(= (list-ref s-list i) target) (loop (+ 1 i) swaps (cons (list-ref s-list i) (cdr s-list)))]
        [else (let ([j (findf-index (lambda (c) (equal? c target)) (list-tail s-list (+ 1 i)))])
                (if (null? j)
                    #f  ; Impossible
                    (let ([k (+ i 1 j)])
                      (loop (+ 1 i) (+ 1 swaps) (append (take s-list i) (list (list-ref s-list k)) (take (list-drop s-list i 1) j) (list (list-ref s-list i)) (list-drop s-list (+ k 1)))))))])))

  (define swaps-0 (count-swaps s #\0))
  (define swaps-1 (count-swaps s #\1))

  (cond
    [(and swaps-0 swaps-1) (min swaps-0 swaps-1)]
    [swaps-0 swaps-0]
    [swaps-1 swaps-1]
    [else 0]))

(define (findf-index pred lst)
  (let loop ([index 0] [l lst])
    (cond
      [(null? l) null]
      [(pred (car l)) index]
      [else (loop (+ 1 index) (cdr l))])))