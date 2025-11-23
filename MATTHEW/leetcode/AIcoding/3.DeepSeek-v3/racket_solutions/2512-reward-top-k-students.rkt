(define (top-students positive_feedback negative_feedback report student_id k)
  (define (count-words feedback-words report-line)
    (define words (string-split report-line))
    (for/sum ([word words])
      (if (member word feedback-words) 1 0)))

  (define positive-set (list->set positive_feedback))
  (define negative-set (list->set negative_feedback))

  (define scores
    (for/list ([id student_id] [r report])
      (define pos (count-words positive-set r))
      (define neg (count-words negative-set r))
      (cons id (- pos neg))))

  (define sorted (sort scores 
                       (lambda (a b) 
                         (if (= (cdr a) (cdr b))
                             (< (car a) (car b))
                             (> (cdr a) (cdr b))))))

  (take (map car sorted) k))