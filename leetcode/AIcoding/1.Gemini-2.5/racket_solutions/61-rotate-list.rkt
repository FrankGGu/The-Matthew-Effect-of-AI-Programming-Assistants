(struct ListNode (val next) #:mutable)

(define (rotate-right head k)
  (if (null? head)
      null
      (let loop-length ((current head)
                        (len 0)
                        (tail null))
        (if (null? current)
            (let* ((list-length len)
                   (effective-k (modulo k list-length)))
              (if (= effective-k 0)
                  head
                  (begin
                    (set-list-node-next! tail head)
                    (let loop-find-new-tail ((curr head)
                                             (steps-to-new-tail (- list-length effective-k 1)))
                      (if (= steps-to-new-tail 0)
                          (let ((new-head (list-node-next curr)))
                            (set-list-node-next! curr null)
                            new-head)
                          (loop-find-new-tail (list-node-next curr) (- steps-to-new-tail 1)))))))
            (loop-length (list-node-next current) (+ len 1) current)))))