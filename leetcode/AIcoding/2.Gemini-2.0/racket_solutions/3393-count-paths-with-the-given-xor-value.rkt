(define (count-paths-with-given-xor-value root target)
  (letrec ((dfs (lambda (node current-xor)
                     (cond
                       ((null? node) 0)
                       (else
                        (let ((new-xor (bitwise-xor current-xor (car node))))
                          (+ (if (= new-xor target) 1 0)
                             (dfs (cadr node) new-xor)
                             (dfs (caddr node) new-xor))))))))
    (dfs root 0)))