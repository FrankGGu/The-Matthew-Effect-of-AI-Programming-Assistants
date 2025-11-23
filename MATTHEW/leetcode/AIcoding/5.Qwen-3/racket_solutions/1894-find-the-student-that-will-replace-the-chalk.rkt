(define/contract (chalk-replace- chalk n)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let ((total (apply + chalk)))
    (let ((remaining (modulo n total)))
      (let loop ((i 0) (sum 0))
        (if (= sum remaining)
            i
            (loop (+ i 1) (+ sum (list-ref chalk i))))))))