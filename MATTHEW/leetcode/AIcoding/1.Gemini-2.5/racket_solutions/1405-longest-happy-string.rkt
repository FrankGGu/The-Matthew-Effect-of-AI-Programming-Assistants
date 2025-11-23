(define (longest-happy-string a b c)
  (let loop ((counts (list (list a #\a) (list b #\b) (list c #\c)))
             (result ""))
    (let* ((sorted-counts (sort counts (lambda (x y) (> (car x) (car y)))))
           (item1 (car sorted-counts))
           (char1 (cadr item1))
           (count1 (car item1))
           (item2 (cadr sorted-counts))
           (char2 (cadr item2))
           (count2 (car item2)))

      (define (can-append? current-char current-count)
        (and (> current-count 0)
             (or (< (string-length result) 2)
                 (not (and (char=? (string-ref result (- (string-length result) 1)) current-char)
                           (char=? (string-ref result (- (string-length result) 2)) current-char))))))

      (cond
        ((can-append? char1 count1)
         (let ((new-counts (map (lambda (p) (if (char=? (cadr p) char1) (list (- (car p) 1) char1) p)) counts)))
           (loop new-counts (string-append result (string char1)))))

        ((can-append? char2 count2)
         (let ((new-counts (map (lambda (p) (if (char=? (cadr p) char2) (list (- (car p) 1) char2) p)) counts)))
           (loop new-counts (string-append result (string char2)))))

        (else
         result)))))