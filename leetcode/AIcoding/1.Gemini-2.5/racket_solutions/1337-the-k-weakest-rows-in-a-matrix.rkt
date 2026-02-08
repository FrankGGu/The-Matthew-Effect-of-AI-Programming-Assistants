(require srfi/1)

(define (k-weakest-rows mat k)
  (let* ((rows-with-soldiers
          (map (lambda (row-idx row)
                 (list (count (lambda (x) (= x 1)) row) row-idx))
               (range (length mat))
               mat))
         (sorted-rows
          (sort rows-with-soldiers
                (lambda (a b)
                  (let ((soldiers-a (car a))
                        (idx-a (cadr a))
                        (soldiers-b (car b))
                        (idx-b (cadr b)))
                    (or (< soldiers-a soldiers-b)
                        (and (= soldiers-a soldiers-b)
                             (< idx-a idx-b)))))))
         (k-weakest-rows-data
          (take sorted-rows k)))
    (map cadr k-weakest-rows-data)))