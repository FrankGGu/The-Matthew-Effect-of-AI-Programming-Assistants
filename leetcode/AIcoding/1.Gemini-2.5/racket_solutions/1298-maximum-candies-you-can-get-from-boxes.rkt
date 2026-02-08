#lang racket

(define (make-queue)
  (let ((head '()) (tail '()))
    (list head tail))) ; (list (front-list) (reversed-back-list))

(define (queue-empty? q)
  (and (null? (car q)) (null? (cadr q))))

(define (enqueue! q item)
  (set-car! (cdr q) (cons item (cadr q)))) ; Add to tail (reversed list)

(define (dequeue! q)
  (when (null? (car q))
    (set-car! q (reverse (cadr q)))
    (set-car! (cdr q) '()))
  (let ((item (car (car q))))
    (set-car! q (cdr (car q)))
    item))

(define (maximum-candies status candies keys containedBoxes initialBoxes)
  (define n (vector-length status))

  ;; State variables
  (define total-candies 0)
  (define has-key (make-vector n #f))   ; has-key[i] is #t if we have key for box i
  (define has-box (make-vector n #f))   ; has-box[i] is #t if we have access to box i
  (define opened (make-vector n #f))    ; opened[i] is #t if box i has been processed
  ;; pending-openable[i] is #t if box i is has-box but not opened and needs a key to open
  (define pending-openable (make-vector n #f))

  ;; Queue for BFS
  (define q (make-queue))

  ;; Initialize initialBoxes
  (for-each (lambda (box-idx)
              (vector-set! has-box box-idx #t)
              (if (= (vector-ref status box-idx) 1)
                  (enqueue! q box-idx)
                  (vector-set! pending-openable box-idx #t)))
            initialBoxes)

  ;; Main BFS loop
  (let loop ()
    (when (not (queue-empty? q))
      (let ((current-box (dequeue! q)))
        ;; Process box only if not already opened
        (unless (vector-ref opened current-box)
          (vector-set! opened current-box #t)
          (set! total-candies (+ total-candies (vector-ref candies current-box)))

          ;; Check for keys inside current-box
          (for-each (lambda (key-idx)
                      (unless (vector-ref has-key key-idx) ; If we don't have this key yet
                        (vector-set! has-key key-idx #t)
                        ;; If this key unlocks a box we already have access to and is pending
                        (when (vector-ref pending-openable key-idx)
                          (enqueue! q key-idx)
                          (vector-set! pending-openable key-idx #f)))) ; No longer pending, now in queue
                    (vector-ref keys current-box))

          ;; Check for contained boxes inside current-box
          (for-each (lambda (contained-box-idx)
                      (unless (vector-ref has-box contained-box-idx) ; If we don't have access to this box yet
                        (vector-set! has-box contained-box-idx #t)
                        ;; If the new box is open or we already have its key, enqueue it
                        (if (or (= (vector-ref status contained-box-idx) 1)
                                (vector-ref has-key contained-box-idx))
                            (enqueue! q contained-box-idx)
                            (vector-set! pending-openable contained-box-idx #t))))
                    (vector-ref containedBoxes current-box))))
      (loop))) ; Continue BFS

  total-candies)