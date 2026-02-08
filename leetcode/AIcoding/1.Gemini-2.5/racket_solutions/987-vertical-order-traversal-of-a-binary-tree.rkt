#lang racket

(define (vertical-order-traversal root)
  (define nodes-with-coords '())

  ;; DFS to traverse the tree and collect nodes along with their
  ;; column and row coordinates.
  ;; Root is (0, 0). Left child is (col-1, row+1), Right child is (col+1, row+1).
  (define (dfs node col row)
    (when node
      ;; Store (column, row, value) for each node
      (set! nodes-with-coords (cons (list col row (TreeNode-val node)) nodes-with-coords))
      (dfs (TreeNode-left node) (- col 1) (+ row 1))
      (dfs (TreeNode-right node) (+ col 1) (+ row 1))))

  ;; Start DFS from the root with initial coordinates (0, 0)
  (dfs root 0 0)

  ;; Sort the collected nodes based on the problem's requirements:
  ;; 1. Primarily by column (ascending)
  ;; 2. Secondarily by row (ascending)
  ;; 3. Thirdly by value (ascending)
  (define sorted-nodes
    (sort nodes-with-coords
          (lambda (a b)
            (let ((col-a (car a))
                  (row-a (cadr a))
                  (val-a (caddr a))
                  (col-b (car b))
                  (row-b (cadr b))
                  (val-b (caddr b)))
              (or (< col-a col-b)
                  (and (= col-a col-b) (< row-a row-b))
                  (and (= col-a col-b) (= row-a row-b) (< val-a val-b)))))))

  ;; Group the sorted nodes by column and extract their values.
  ;; This function iterates through the sorted list, accumulating values for each column.
  (define (group-and-extract nodes)
    (if (empty? nodes)
        '()
        (let loop ((remaining-nodes nodes)
                   (result '())             ; Accumulates lists of node values for each column
                   (current-group '())      ; Accumulates node values for the current column
                   (current-col (car (car nodes)))) ; Column of the first node in the sorted list
          (if (empty? remaining-nodes)
              ;; If all nodes have been processed, add the last accumulated group
              ;; (reversed because values were consed) and reverse the final result list.
              (reverse (cons (reverse current-group) result))
              (let* ((node-info (car remaining-nodes))
                     (col (car node-info))
                     (val (caddr node-info)))
                (if (= col current-col)
                    ;; If the current node belongs to the same column, add its value
                    ;; to the current group.
                    (loop (cdr remaining-nodes) result (cons val current-group) current-col)
                    ;; If it's a new column, finalize the current group, add it to the result,
                    ;; and start a new group for the new column.
                    (loop (cdr remaining-nodes) (cons (reverse current-group) result) (list val) col)))))))

  ;; Call the grouping function on the sorted list of nodes
  (group-and-extract sorted-nodes))