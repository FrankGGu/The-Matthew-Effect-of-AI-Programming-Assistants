#lang racket

(struct node (count keys prev next) #:mutable)

(struct AllOne (key-counts count-to-node head tail) #:mutable)

(define (add-after prev-node new-node)
  (define next-node (node-next prev-node))
  (set-node-next! prev-node new-node)
  (set-node-prev! new-node prev-node)
  (set-node-next! new-node next-node)
  (set-node-prev! next-node new-node))

(define (add-before next-node new-node)
  (define prev-node (node-prev next-node))
  (set-node-next! prev-node new-node)
  (set-node-prev! new-node prev-node)
  (set-node-next! new-node next-node)
  (set-node-prev! next-node new-node))

(define (remove-node node-to-remove)
  (define prev-node (node-prev node-to-remove))
  (define next-node (node-next node-to-remove))
  (set-node-next! prev-node next-node)
  (set-node-prev! next-node prev-node)
  (set-node-prev! node-to-remove #f)
  (set-node-next! node-to-remove #f))

(define (AllOne%)
  (define head-node (node -1 (set) #f #f))
  (define tail-node (node -1 (set) #f #f))
  (set-node-next! head-node tail-node)
  (set-node-prev! tail-node head-node)
  (AllOne (make-hash) (make-hash) head-node tail-node))

(define (AllOne-inc this key)
  (define key-counts (AllOne-key-counts this))
  (define count-to-node (AllOne-count-to-node this))
  (define head (AllOne-head this))
  (define tail (AllOne-tail this))

  (define old-count (hash-ref key-counts key 0))
  (define new-count (+ old-count 1))

  (hash-set! key-counts key new-count)

  (when (> old-count 0)
    (define old-node (hash-ref count-to-node old-count))
    (set-node-keys! old-node (set-remove (node-keys old-node) key))
    (when (set-empty? (node-keys old-node))
      (remove-node old-node)
      (hash-remove! count-to-node old-count)))

  (define new-node (hash-ref count-to-node new-count #f))
  (unless new-node
    (set! new-node (node new-count (set) #f #f))
    (hash-set! count-to-node new-count new-node)

    (let ((prev-node-for-new-node (hash-ref count-to-node (- new-count 1) #f)))
      (if prev-node-for-new-node
          (add-after prev-node-for-new-node new-node)
          (let loop ((curr (node-next head)))
            (if (or (eq? curr tail)
                    (> (node-count curr) new-count))
                (add-before curr new-node)
                (loop (node-next curr)))))))
  (set-node-keys! new-node (set-add (node-keys new-node) key)))

(define (AllOne-dec this key)
  (define key-counts (AllOne-key-counts this))
  (define count-to-node (AllOne-count-to-node this))
  (define head (AllOne-head this))
  (define tail (AllOne-tail this))

  (define old-count (hash-ref key-counts key 0))
  (when (> old-count 0)
    (define new-count (- old-count 1))

    (define old-node (hash-ref count-to-node old-count))
    (set-node-keys! old-node (set-remove (node-keys old-node) key))
    (when (set-empty? (node-keys old-node))
      (remove-node old-node)
      (hash-remove! count-to-node old-count))

    (if (> new-count 0)
        (begin
          (hash-set! key-counts key new-count)
          (define new-node (hash-ref count-to-node new-count #f))
          (unless new-node
            (set! new-node (node new-count (set) #f #f))
            (hash-set! count-to-node new-count new-node)

            (let ((next-node-for-new-node (hash-ref count-to-node (+ new-count 1) #f)))
              (if next-node-for-new-node
                  (add-before next-node-for-new-node new-node)
                  (let loop ((curr (node-prev tail)))
                    (if (or (eq? curr head)
                            (< (node-count curr) new-count))
                        (add-after curr new-node)
                        (loop (node-prev curr)))))))
          (set-node-keys! new-node (set-add (node-keys new-node) key)))
        (hash-remove! key-counts key))))

(define (AllOne-get-max-key this)
  (define head (AllOne-head this))
  (define tail (AllOne-tail this))
  (define last-node (node-prev tail))
  (if (eq? last-node head)
      ""
      (set-first (node-keys last-node))))

(define (AllOne-get-min-key this)
  (define head (AllOne-head this))
  (define tail (AllOne-tail this))
  (define first-node (node-next head))
  (if (eq? first-node tail)
      ""
      (set-first (node-keys first-node))))