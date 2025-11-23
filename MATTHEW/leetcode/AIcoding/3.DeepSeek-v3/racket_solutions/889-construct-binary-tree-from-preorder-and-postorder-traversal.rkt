#lang racket

(define (construct-from-pre-post pre post)
  (define (helper pre-start pre-end post-start post-end)
    (if (> pre-start pre-end)
        '()
        (let* ([root-val (list-ref pre pre-start)]
               [left-root (if (< (add1 pre-start) (length pre))
                              (list-ref pre (add1 pre-start))
                              #f)]
               [left-post-idx (if left-root
                                  (index-of post left-root post-start)
                                  post-start)]
               [left-size (if left-root
                              (- left-post-idx post-start 1)
                              -1)])
          (list root-val
                (helper (+ pre-start 1) (+ pre-start 1 left-size) post-start left-post-idx)
                (helper (+ pre-start 2 left-size) pre-end (+ left-post-idx 1) (- post-end 1))))))
  (helper 0 (- (length pre) 1) 0 (- (length post) 1)))