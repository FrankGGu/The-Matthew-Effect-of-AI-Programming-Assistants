#lang racket

(define-type TreeNode
  (struct TreeNode (val left right)))

(define (flipMatchVoyage root voyage)
  (define (helper node voyage index)
    (if (or (null? node) (>= index (length voyage)))
        (values index #t)
        (if (= (TreeNode-val node) (list-ref voyage index))
            (let-values ([(next-index flipped?) 
                           (helper (TreeNode-left node) voyage (add1 index))])
              (if (and (not flipped?) 
                       (not (equal? (TreeNode-val (TreeNode-right node)) (list-ref voyage next-index))))
                  (let-values ([(next-index' _) 
                                 (helper (TreeNode-right node) voyage index)])
                    (values next-index' #f))
                  (helper (TreeNode-right node) voyage (add1 next-index))))
            (values index #f)))
  (define (collect-flips node voyage index)
    (if (or (null? node) (>= index (length voyage)))
        '()
        (let-values ([(next-index flipped?)
                       (helper node voyage index)])
          (if (not flipped?)
              (cons (TreeNode-val node) (collect-flips (TreeNode-right node) voyage next-index))
              (collect-flips (TreeNode-left node) voyage next-index)))))
  (define result (collect-flips root voyage 0))
  (if (equal? result voyage)
      '()
      result))

(define (createTree nodes)
  (if (null? nodes)
      #f
      (let ([val (car nodes)]
            [left (createTree (cdr nodes))]
            [right (createTree (cdr (cdr nodes)))])
        (TreeNode val left right))))

(define (flipBinaryTreeToMatchPreorderTraversal root voyage)
  (flipMatchVoyage root voyage))