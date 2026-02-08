(define (countZeroRequestServers servers)
  (define (count-zero-requests servers)
    (foldl (lambda (server acc)
             (if (= server 0) (+ acc 1) acc))
           0
           servers))
  (count-zero-requests servers))

(countZeroRequestServers '(0 1 0 2 0 3))