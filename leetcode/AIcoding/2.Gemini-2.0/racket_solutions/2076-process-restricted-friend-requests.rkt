(define (process-restricted-friend-requests n requests restrictions)
  (let* ((adj (make-vector n '()))
         (restricted-set (set))
         (result '()))
    (for ([r restrictions])
      (set-add! restricted-set (list (min (car r) (cadr r)) (max (car r) (cadr r)))))

    (define (can-add? u v)
      (not (set-member? restricted-set (list (min u v) (max u v)))))

    (define (is-bipartite? start)
      (let ((color (make-vector n #f)))
        (define (dfs u c)
          (vector-set! color u c)
          (for ([v (vector-ref adj u)])
            (cond
              [(equal? (vector-ref color v) #f)
               (if (not (dfs v (not c)))
                   #f)]
              [(equal? (vector-ref color v) c)
               (return #f)])))
          #t)

        (let loop ([i 0])
          (cond
            [(>= i n) #t]
            [(equal? (vector-ref color i) #f)
             (if (not (dfs i #t))
                 #f)
             (loop (+ i 1))]
            [else (loop (+ i 1))])))

    (for ([req requests])
      (let ((u (car req)) (v (cadr req)))
        (if (can-add? u v)
            (begin
              (vector-set! adj u (cons v (vector-ref adj u)))
              (vector-set! adj v (cons u (vector-ref adj v)))
              (if (is-bipartite? 0)
                  (begin
                    (set! result (cons #t result)))
                  (begin
                    (vector-set! adj u (filter (lambda (x) (not (equal? x v))) (vector-ref adj u)))
                    (vector-set! adj v (filter (lambda (x) (not (equal? x u))) (vector-ref adj v)))
                    (set! result (cons #f result)))))
            (set! result (cons #f result)))))
    (reverse result)))