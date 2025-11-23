#lang racket/base
(require racket/list)

(define char-map '((#\R . 0) (#\Y . 1) (#\B . 2) (#\G . 3) (#\W . 4)))
(define (char->idx c) (cdr (assoc c char-map)))
(define (idx->char idx) (car (findf (lambda (p) (= (cdr p) idx)) char-map)))

(define (hand-to-counts hand-str)
  (let ((counts (make-list (length char-map) 0)))
    (for ((c (string->list hand-str)))
      (let ((idx (char->idx c)))
        (set! counts (list-set counts idx (+ (list-ref counts idx) 1)))))
    counts))

(define (list-remove-block lst start-idx end-idx)
  (append (take lst start-idx) (drop lst (+ end-idx 1))))

(define (clean-board-list lst)
  (let loop ((current-lst lst))
    (let* ((n (length current-lst))
           (found-block #f)
           (next-lst current-lst))
      (let find-and-remove ((i 0))
        (when (and (not found-block) (< i (- n 2))) ; Need at least 3 balls to form a block
          (let* ((char (list-ref current-lst i))
                 (j i))
            (for ((k i) #:when (< k n) #:while (char=? (list-ref current-lst k) char))
              (set! j k)) ; j is the last index of the block of 'char'
            (let ((count (- (+ j 1) i)))
              (when (>= count 3)
                (set! found-block #t)
                (set! next-lst (list-remove-block current-lst i j))))
            (unless found-block
              (find-and-remove (+ j 1)))))) ; Move to next potential block
      (if found-block
          (loop next-lst) ; Recurse if a block was removed
          current-lst)))) ; No blocks found, board is clean

(define memo (make-hash))

(define (solve board-str hand-counts)
  (cond
    ((string=? board-str "") 0) ; Board is empty, 0 balls needed
    (else
     (let ((key (cons board-str hand-counts)))
       (hash-ref! memo key
                  (lambda ()
                    (let ((min-balls (expt 10 9))) ; Use a large integer for infinity
                      (let ((n (string-length board-str))
                            (board-list (string->list board-str)))
                        (for* ((i (range (+ n 1))) ; Insertion points: 0 to n (inclusive)
                               (idx (range (length char-map)))) ; Iterate through each color
                               (when (> (list-ref hand-counts idx) 0)) ; Only if we have this color in hand
                          (let* ((char-to-insert (idx->char idx))
                                 ;; Decrement count for the used ball
                                 (new-hand-counts (list-set hand-counts idx (- (list-ref hand-counts idx) 1)))
                                 ;; Insert the ball into the board
                                 (temp-board-list (append (take board-list i)
                                                          (list char-to-insert)
                                                          (drop board-list i)))
                                 ;; Clean the board after insertion
                                 (cleaned-board-list (clean-board-list temp-board-list))
                                 (cleaned-board-str (list->string cleaned-board-list))
                                 ;; Recurse
                                 (res (solve cleaned-board-str new-hand-counts)))
                            (when (< res (expt 10 9)) ; If recursive call found a solution
                              (set! min-balls (min min-balls (+ 1 res)))))))
                      min-balls)))))))

(define (find-min-step board hand)
  (set! memo (make-hash)) ; Clear memoization for each test case
  (let* ((initial-hand-counts (hand-to-counts hand))
         (result (solve board initial-hand-counts)))
    (if (= result (expt 10 9)) -1 result)))