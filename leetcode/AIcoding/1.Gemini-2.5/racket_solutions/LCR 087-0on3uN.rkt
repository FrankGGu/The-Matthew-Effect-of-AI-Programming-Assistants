(define (restore-ip-addresses s)
  (define n (string-length s))

  (define (is-valid-segment segment-str)
    (let ((len (string-length segment-str)))
      (cond
        ((or (= len 0) (> len 3)) #f)
        ((and (> len 1) (char=? (string-ref segment-str 0) #\0)) #f)
        (else
         (let ((num (string->number segment-str)))
           (and (not (not num))
                (>= num 0)
                (<= num 255)))))))

  (define (backtrack start-index current-segments)
    (cond
      ((= (length current-segments) 4)
       (if (= start-index n)
           (list (string-join current-segments "."))
           '()))
      ((or (> start-index n)
           (< (- n start-index) (- 4 (length current-segments)))
           (> (- n start-index) (* 3 (- 4 (length current-segments)))))
       '())
      (else
       (apply append
              (for/list ([i (in-range 1 4)])
                (let* ((end-index (+ start-index i)))
                  (if (<= end-index n)
                      (let ((segment (substring s start-index end-index)))
                        (if (is-valid-segment segment)
                            (backtrack end-index (append current-segments (list segment)))
                            '()))
                      '())))))))

  (backtrack 0 '()))