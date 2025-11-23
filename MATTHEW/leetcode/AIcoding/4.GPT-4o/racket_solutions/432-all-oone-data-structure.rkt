(define AllOne
  (lambda ()
    (define freq (make-hash))
    (define head (list 'head 0 'next '()))
    (define tail (list 'tail 0 'prev '()))
    (set-cdr! head tail)
    (set-cdr! tail head)

    (define (add-node new-node prev-node next-node)
      (set-cdr! prev-node new-node)
      (set-cdr! new-node next-node)
      (set-cdr! new-node prev-node)
      (set-cdr! next-node new-node))

    (define (remove-node node)
      (let ((prev (caddr node))
            (next (cadddr node)))
        (set-cdr! prev next)
        (set-cdr! next prev)))

    (define (inc key)
      (define count (hash-ref freq key 0))
      (hash-set! freq key (+ count 1))
      (define new-count (+ count 1))
      (define node (hash-ref freq new-count '()))
      (if (null? node)
          (begin
            (set! node (list new-count '() '()))
            (add-node node (hash-ref freq count '()) tail)))
      (remove-node (hash-ref freq count '()))
      (when (= count 1)
        (hash-remove! freq key)))

    (define (dec key)
      (define count (hash-ref freq key 0))
      (if (= count 1)
          (begin
            (hash-remove! freq key)
            (remove-node (hash-ref freq 1 '())))
          (begin
            (hash-set! freq key (- count 1))
            (define new-count (- count 1))
            (define node (hash-ref freq new-count '()))
            (if (null? node)
                (begin
                  (set! node (list new-count '() '()))
                  (add-node node (hash-ref freq count '()) tail)))
            (remove-node (hash-ref freq count '())))))

    (define (get_max_key)
      (car (cdr (cadr (cdr head)))))

    (define (get_min_key)
      (car (cdr (cadr (cdr tail)))))

    (lambda (command . args)
      (cond
        ((equal? command 'inc) (inc (car args)))
        ((equal? command 'dec) (dec (car args)))
        ((equal? command 'get_max_key) (get_max_key))
        ((equal? command 'get_min_key) (get_min_key))))))

(define allOne (AllOne))