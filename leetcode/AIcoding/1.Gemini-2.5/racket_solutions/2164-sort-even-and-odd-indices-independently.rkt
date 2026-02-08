(define (sort-even-odd-indices-independently nums)
  (let loop ((lst nums)
             (index 0)
             (evens '())
             (odds '()))
    (cond
      ((empty? lst)
       (let ((sorted-evens (sort evens <))
             (sorted-odds (sort odds >)))
         (let merge-loop ((se sorted-evens)
                          (so sorted-odds)
                          (res '())
                          (merge-index 0))
           (cond
             ((and (empty? se) (empty? so))
              (reverse res))
             ((even? merge-index)
              (merge-loop (rest se) so (cons (first se) res) (+ merge-index 1)))
             (else
              (merge-loop se (rest so) (cons (first so) res) (+ merge-index 1)))))))
      ((even? index)
       (loop (rest lst) (+ index 1) (cons (first lst) evens) odds))
      (else
       (loop (rest lst) (+ index 1) evens (cons (first lst) odds))))))