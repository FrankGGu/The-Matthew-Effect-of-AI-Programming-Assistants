(define (majority-element-ii nums)
  (define n (length nums))
  (when (zero? n) '())

  ;; First pass: Find potential candidates using Boyer-Moore Majority Vote Algorithm extension
  ;; acc = (list cand1 count1 cand2 count2)
  (define-values (cand1 count1 cand2 count2)
    (foldl (lambda (x acc)
             (define current-cand1 (car acc))
             (define current-count1 (cadr acc))
             (define current-cand2 (caddr acc))
             (define current-count2 (cadddr acc))

             (cond
               ((equal? x current-cand1)
                (list current-cand1 (+ current-count1 1) current-cand2 current-count2))
               ((equal? x current-cand2)
                (list current-cand1 current-count1 current-cand2 (+ current-count2 1)))
               ((zero? current-count1)
                (list x 1 current-cand2 current-count2))
               ((zero? current-count2)
                (list current-cand1 current-count1 x 1))
               (else ; x is not a candidate and both counts are > 0
                (list current-cand1 (- current-count1 1) current-cand2 (- current-count2 1)))))
           (list #f 0 #f 0) ; Initial state: #f as dummy candidate, 0 count
           nums))

  ;; Second pass: Verify counts of potential candidates
  ;; acc = (list final-count1 final-count2)
  (define-values (final-count1 final-count2)
    (foldl (lambda (x acc)
             (define current-final-count1 (car acc))
             (define current-final-count2 (cadr acc))
             (cond
               ((equal? x cand1)
                (list (+ current-final-count1 1) current-final-count2))
               ((equal? x cand2)
                (list current-final-count1 (+ current-final-count2 1)))
               (else ; x is neither cand1 nor cand2
                (list current-final-count1 current-final-count2))))
           (list 0 0)
           nums))

  ;; Construct the result list functionally
  (define threshold (floor (/ n 3)))

  (let ((res-temp
         (if (and (> final-count1 threshold) (not (equal? cand1 #f)))
             (list cand1)
             '())))
    (if (and (> final-count2 threshold) (not (equal? cand2 #f)) (not (equal? cand1 cand2)))
        (append res-temp (list cand2))
        res-temp)))