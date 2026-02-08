(require data/rbl-tree)
(require data/heap)

(define (calculate-gap-props start-val end-val N)
  (cond
    ((= start-val -1)
     (list end-val 0))
    ((= end-val N)
     (list (- N 1 start-val) (- N 1)))
    (else
     (let* ((dist (quotient (- end-val start-val) 2))
            (seat (+ start-val dist)))
       (list dist seat)))))

(define-struct exam-room (N occupied-seats gaps) #:mutable)

(define (make-exam-room N)
  (define er (struct exam-room N (rbl-tree-set) (make-heap (lambda (a b) (or (> (car a) (car b)) (and (= (car a) (car b)) (< (cadr a) (cadr b))))))))
  (let* ((props (calculate-gap-props -1 N N))
         (dist (car props))
         (seat-idx (cadr props)))
    (heap-add! (exam-room-gaps er) (list dist seat-idx -1 N)))
  er)

(define (exam-room-seat er)
  (let loop ()
    (let* ((best-gap-info (heap-min (exam-room-gaps er)))
           (seat-idx (cadr best-gap-info))
           (start-gap (caddr best-gap-info))
           (end-gap (cadddr best-gap-info)))

      (define (is-gap-valid?)
        (define occupied (exam-room-occupied-seats er))
        (define N (exam-room-N er))
        (cond
          ((rbl-tree-set-empty? occupied)
           (and (= start-gap -1) (= end-gap N)))
          ((= start-gap -1)
           (and (not (rbl-tree-set-member? occupied 0))
                (equal? (rbl-tree-set-min occupied) end-gap)))
          ((= end-gap N)
           (and (not (rbl-tree-set-member? occupied (- N 1)))
                (equal? (rbl-tree-set-max occupied) start-gap)))
          (else
           (and (rbl-tree-set-member? occupied start-gap)
                (rbl-tree-set-member? occupied end-gap)
                (equal? (rbl-tree-set-successor occupied start-gap) end-gap))))))

      (if (is-gap-valid?)
          (begin
            (heap-remove-min! (exam-room-gaps er))
            (rbl-tree-set-add! (exam-room-occupied-seats er) seat-idx)

            (when (< start-gap seat-idx)
              (let* ((props (calculate-gap-props start-gap seat-idx (exam-room-N er)))
                     (d (car props))
                     (s (cadr props)))
                (heap-add! (exam-room-gaps er) (list d s start-gap seat-idx))))

            (when (< seat-idx end-gap)
              (let* ((props (calculate-gap-props seat-idx end-gap (exam-room-N er)))
                     (d (car props))
                     (s (cadr props)))
                (heap-add! (exam-room-gaps er) (list d s seat-idx end-gap))))
            seat-idx)
          (begin
            (heap-remove-min! (exam-room-gaps er))
            (loop))))))

(define (exam-room-leave er p)
  (rbl-tree-set-remove! (exam-room-occupied-seats er) p)

  (define occupied (exam-room-occupied-seats er))
  (define N (exam-room-N er))

  (define prev-p
    (let ((pred (rbl-tree-set-predecessor occupied p)))
      (if pred pred -1)))

  (define next-p
    (let ((succ (rbl-tree-set-successor occupied p)))
      (if succ succ N)))

  (let* ((props (calculate-gap-props prev-p next-p N))
         (d (car props))
         (s (cadr props)))
    (heap-add! (exam-room-gaps er) (list d s prev-p next-p)))
  (void))