(define (construct-from-pre-post preorder postorder)
  (define (build pre p-start p-end post s-start s-end)
    (if (= p-start p-end)
        (list (list-ref pre p-start))
        (let* ((root (list-ref pre p-start))
               (left-root (list-ref post s-start))
               (left-size (index-of pre left-root p-start p-end))
               (right-root (list-ref post (- s-end 1)))
               (right-size (- (- s-end s-start) left-size 1)))
          (cons root (list (build pre (+ p-start 1) (+ p-start left-size) post s-start (+ s-start left-size))
                           (build pre (+ p-start (+ left-size 1)) p-end post (+ s-start left-size) (- s-end 1)))))))
  (build preorder 0 (sub1 (length preorder)) post 0 (sub1 (length post))))

(define (index-of lst val start end)
  (define (loop i)
    (if (>= i end)
        -1
        (if (= (list-ref lst i) val)
            i
            (loop (add1 i)))))
  (loop start))

(define (constructFromPrePost preorder postorder)
  (construct-from-pre-post preorder postorder))