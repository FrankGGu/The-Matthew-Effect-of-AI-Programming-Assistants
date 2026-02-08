(define (are-almost-equal s1 s2)
  (let ((len (string-length s1)))
    (let loop ((i 0) (diff-pairs '()) (diff-count 0))
      (cond
        ((= i len)
         (case diff-count
           [0 #t]
           [2 (let* ((pair1 (car diff-pairs))
                     (pair2 (cadr diff-pairs))
                     (s1-c1 (car pair1))
                     (s2-c1 (cadr pair1))
                     (s1-c2 (car pair2))
                     (s2-c2 (cadr pair2)))
                (and (char=? s1-c1 s2-c2)
                     (char=? s1-c2 s2-c1)))]
           [else #f]))
        ((> diff-count 2)
         #f)
        (else
         (let ((c1 (string-ref s1 i))
               (c2 (string-ref s2 i)))
           (if (char=? c1 c2)
               (loop (+ i 1) diff-pairs diff-count)
               (loop (+ i 1) (cons (list c1 c2) diff-pairs) (+ diff-count 1)))))))))