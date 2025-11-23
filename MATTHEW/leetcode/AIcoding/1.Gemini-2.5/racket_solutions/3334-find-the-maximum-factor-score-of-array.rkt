#lang racket

(define MAX_NUM 1000000)

(define factor-scores (make-vector (+ MAX_NUM 1) 0))

(for ((i (in-range 1 (add1 MAX_NUM))))
  (for ((j (in-range i (add1 MAX_NUM) i)))
    (vector-set! factor-scores j (+ (vector-ref factor-scores j) i))))

(define (max-factor-score nums)
  (let* ((first-num (car nums))
         (first-score (vector-ref factor-scores first-num)))
    (let loop ((nums-list (cdr nums))
               (max-s first-score)
               (res-n first-num))
      (if (empty? nums-list)
          res-n
          (let* ((current-num (car nums-list))
                 (current-s (vector-ref factor-scores current-num)))
            (cond
              ((> current-s max-s)
               (loop (cdr nums-list) current-s current-num))
              ((= current-s max-s)
               (loop (cdr nums-list) max-s (min res-n current-num)))
              (else
               (loop (cdr nums-list) max-s res-n))))))))