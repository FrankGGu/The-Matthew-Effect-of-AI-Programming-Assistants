(define (majorityElement nums)
  (define (findCandidates nums)
    (let loop ((nums nums) (candidate1 #f) (candidate2 #f) (count1 0) (count2 0))
      (cond
        [(null? nums) (list candidate1 candidate2)]
        [(equal? (car nums) candidate1) (loop (cdr nums) candidate1 candidate2 (+ count1 1) count2)]
        [(equal? (car nums) candidate2) (loop (cdr nums) candidate1 candidate2 count1 (+ count2 1))]
        [(= count1 0) (loop (cdr nums) (car nums) candidate2 count1 1)]
        [(= count2 0) (loop (cdr nums) candidate1 (car nums) count1 1)]
        [else (loop (cdr nums) candidate1 candidate2 (- count1 1) (- count2 1))])))

  (define (countCandidates nums candidates)
    (let loop ((nums nums) (candidates candidates) (counts (list 0 0)))
      (if (null? nums)
          (list (if (> (car counts) (/ (length nums) 3)) (car candidates) #f)
                (if (> (cadr counts) (/ (length nums) 3)) (cadr candidates) #f))
          (let ((candidate (car candidates)))
            (if (equal? (car nums) candidate)
                (loop (cdr nums) candidates (list (+ (car counts) 1) (cadr counts)))
                (loop (cdr nums) candidates counts))))))

  (let ((candidates (findCandidates nums)))
    (countCandidates nums candidates)))