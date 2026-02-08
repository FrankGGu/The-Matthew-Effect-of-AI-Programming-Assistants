(define-node (value next))

(define (MyLinkedList)
  (define head (make-node 0 #f))
  (define size 0)

  (define (get node index)
    (if (or (< index 0) (>= index size))
        -1
        (let loop ((curr node) (i 0))
          (if (= i index)
              (node-value curr)
              (loop (node-next curr) (+ i 1))))))

  (define (add-node node index value)
    (if (or (< index 0) (> index size))
        #f
        (let loop ((curr head) (i 0))
          (if (= i index)
              (begin
                (set-node-next (make-node value (node-next curr)) curr)
                (set-node-next curr (node-next curr))
                (set! size (+ size 1)))
              (loop (node-next curr) (+ i 1))))))

  (define (delete-node index)
    (if (or (< index 0) (>= index size))
        #f
        (let loop ((curr head) (i 0))
          (if (= i index)
              (set-node-next curr (node-next (node-next curr)))
              (loop (node-next curr) (+ i 1))))))

  (define (get-size) size)

  (define (get-head) head)

  (define (get-value index) (get head index))

  (define (add-at-head value) (add-node head 0 value))

  (define (add-at-tail value) (add-node head size value))

  (define (add-at-index index value) (add-node head index value))

  (define (delete-at-index index) (delete-node index))

  (lambda (operation . args)
    (case operation
      [(get) (get-value (car args))]
      [(addAtHead) (add-at-head (car args))]
      [(addAtTail) (add-at-tail (car args))]
      [(addAtIndex) (add-at-index (car args) (cadr args))]
      [(deleteAtIndex) (delete-at-index (car args))])))

(define myLinkedList (MyLinkedList))