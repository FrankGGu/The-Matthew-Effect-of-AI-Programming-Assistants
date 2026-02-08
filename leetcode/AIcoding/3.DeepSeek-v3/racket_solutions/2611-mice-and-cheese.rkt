(define (mice-and-cheese reward1 reward2 k)
  (let* ([n (length reward1)]
         [diffs (for/list ([r1 reward1] [r2 reward2]) (- r1 r2))]
         [sorted-indices (sort (range n) > #:key (lambda (i) (list-ref diffs i)))]
         [selected (take sorted-indices k)]
         [total (for/sum ([i selected]) (list-ref reward1 i))]
         [remaining (remove* selected (range n))]
         [total (+ total (for/sum ([i remaining]) (list-ref reward2 i)))])
    total))