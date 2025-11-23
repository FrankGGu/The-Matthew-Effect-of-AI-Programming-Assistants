(define/contract (minimum-right-shifts nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([shifted nums]
             [count 0]
             [n (length nums)])
    (if (sorted? shifted)
        count
        (if (>= count n)
            -1
            (loop (append (list (last shifted)) (drop-right shifted 1)) (+ count 1))))))

(define (sorted? lst)
  (cond [(null? lst) #t]
        [(null? (cdr lst)) #t]
        [else (and (<= (car lst) (cadr lst)) (sorted? (cdr lst)))]))