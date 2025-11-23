#lang racket

(define (recover-from-preorder traversal)
  (define (parse s)
    (let loop ([i 0] [depth 0] [stack '()])
      (if (>= i (string-length s))
          (car stack)
          (let*-values ([(new-i d) (parse-depth s i)]
                        [(new-i val) (parse-value s new-i)])
            (let adjust-stack ([stack stack] [d d])
              (if (= d (length stack))
                  (let ([node (TreeNode val)])
                    (if (null? stack)
                        (loop new-i depth (list node))
                        (let ([parent (car stack)])
                          (if (null? (TreeNode-left parent))
                              (set-TreeNode-left! parent node)
                              (set-TreeNode-right! parent node))
                          (loop new-i depth (cons node stack))))
                  (adjust-stack (cdr stack) d)))))))

  (define (parse-depth s i)
    (let loop ([i i] [d 0])
      (if (and (< i (string-length s)) (char=? (string-ref s i) #\-))
          (loop (+ i 1) (+ d 1))
          (values i d))))

  (define (parse-value s i)
    (let loop ([i i] [val 0])
      (if (and (< i (string-length s)) (char-numeric? (string-ref s i)))
          (loop (+ i 1) (+ (* val 10) (- (char->integer (string-ref s i)) 48)))
          (values i val))))

  (if (string=? traversal "") #f (parse traversal)))

(define-struct TreeNode (val left right) #:transparent)