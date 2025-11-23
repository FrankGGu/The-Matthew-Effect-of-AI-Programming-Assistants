(define (find-mode tree)
  (define (inorder tree acc)
    (cond
      [(null? tree) acc]
      [else (inorder (bst-node-left tree)
                     (let* ([acc (inorder (bst-node-right tree) acc)])
                       (let* ([val (bst-node-val tree)]
                              [count (hash-ref acc val 0)])
                         (hash-set acc val (+ count 1)))))]))

  (define (find-max-freq freqs)
    (let loop ([keys (hash-keys freqs)]
               [max-freq 0]
               [modes '()])
      (cond
        [(null? keys) modes]
        [else
         (let* ([key (car keys)]
                [freq (hash-ref freqs key)])
           (cond
             [(= freq max-freq) (loop (cdr keys) max-freq (cons key modes))]
             [(> freq max-freq) (loop (cdr keys) freq (list key))]
             [else (loop (cdr keys) max-freq modes)]))]))))

  (let* ([freqs (inorder tree (make-hash))]
         [modes (find-max-freq freqs)])
    modes))