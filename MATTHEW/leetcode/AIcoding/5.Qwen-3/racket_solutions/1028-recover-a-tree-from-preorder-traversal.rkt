#lang racket

(define (recover-tree s)
  (define (parse-node s start)
    (let loop ([i start] [val 0])
      (if (or (= i (string-length s)) (char=? #\# (string-ref s i)))
          (values (make-node val) i)
          (loop (+ i 1) (+ (* val 10) (- (char->integer (string-ref s i)) 48)))))))

  (define (build-tree s)
    (let build ([i 0])
      (when (>= i (string-length s)) (void))
      (let-values ([(node next-i) (parse-node s i)])
        (when (and (< next-i (string-length s)) (char=? #\- (string-ref s next-i)))
          (let-values ([(left next-i) (build-tree s)])
            (set-node-left! node left)))
        (when (and (< next-i (string-length s)) (char=? #\- (string-ref s next-i)))
          (let-values ([(right next-i) (build-tree s)])
            (set-node-right! node right)))
        node)))

  (build-tree s))

(define-struct node (val left right) #:mutable)