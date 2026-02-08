(define/contract (delete-duplicates head)
  (-> (or/c null? list?) (or/c null? list?))
  (let loop ([prev #f] [current head] [next (if (null? head) null (cdr head))])
    (cond
      [(null? current) (if prev (cdr prev) null)]
      [(or (null? next) (not (= (car current) (car next))))
       (if prev
           (begin
             (set-cdr! prev (cons (car current) null))
             (loop (cdr prev) next (if (null? next) null (cdr next)))))
           (let ([new-head (cons (car current) null)])
             (loop new-head next (if (null? next) null (cdr next))))))]
      [else
       (let ([val (car current)])
         (let skip ([current current] [next next])
           (cond
             [(or (null? current) (not (= (car current) val))) (loop prev current next)]
             [else (skip next (if (null? next) null (cdr next)))])))])))