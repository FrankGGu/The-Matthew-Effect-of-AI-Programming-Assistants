(define (min-operations nums)
  (define n (length nums))
  (define unique-nums (list->set (sort (remove-duplicates nums) <)))
  (define unique-list (set->list unique-nums))
  (define m (length unique-list))
  (define (solve l)
    (let loop ([i 0] [j 0] [count 0])
      (cond
        [(>= i m) count]
        [else
         (let ([val (list-ref unique-list i)])
           (let loop2 ([jj j])
             (cond
               [(>= jj m) (loop (+ i 1) jj (+ count 1))]
               [(<= val (+ n -1 (list-ref unique-list jj)))
                (loop (+ i 1) jj (+ count (- n (- jj i))))]
               [else (loop2 (+ jj 1))]))])))))

  (solve 0))

(provide min-operations)