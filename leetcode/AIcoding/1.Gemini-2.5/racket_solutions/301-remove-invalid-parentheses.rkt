(define (remove-invalid-parentheses s)
  (define (is-valid current-s)
    (let loop ([i 0] [open 0])
      (cond
        [(>= i (string-length current-s)) (= open 0)]
        [(char=? (string-ref current-s i) #\() (loop (+ i 1) (+ open 1))]
        [(char=? (string-ref current-s i) #\)) (if (> open 0) (loop (+ i 1) (- open 1)) #f)]
        [else (loop (+ i 1) open)])))

  (let* ([len (string-length s)]
         [removals (let loop ([i 0] [left-rem 0] [right-rem 0])
                     (cond
                       [(>= i len) (list left-rem right-rem)]
                       [(char=? (string-ref s i) #\() (loop (+ i 1) (+ left-rem 1) right-rem)]
                       [(char=? (string-ref s i) #\))
                        (if (> left-rem 0)
                            (loop (+ i 1) (- left-rem 1) right-rem)
                            (loop (+ i 1) left-rem (+ right-rem 1)))]
                       [else (loop (+ i 1) left-rem right-rem)]))]
         [left-to-remove (car removals)]
         [right-to-remove (cadr removals)]
         [results (make-hash)])

    (define (backtrack idx current-str-list open-count current-left-rem current-right-rem)
      (when (>= idx len)
        (when (and (= current-left-rem 0)
                   (= current-right-rem 0)
                   (= open-count 0))
          (hash-set! results (list->string (reverse current-str-list)) #t)))
      (when (< idx len)
        (let ([char (string-ref s idx)])
          (cond
            [(char=? char #\()
             ;; Option 1: Don't remove '('
             (backtrack (+ idx 1) (cons char current-str-list) (+ open-count 1) current-left-rem current-right-rem)
             ;; Option 2: Remove '('
             (when (> current-left-rem 0)
               (backtrack (+ idx 1) current-str-list open-count (- current-left-rem 1) current-right-rem))]
            [(char=? char #\))
             ;; Option 1: Don't remove ')'
             (when (> open-count 0)
               (backtrack (+ idx 1) (cons char current-str-list) (- open-count 1) current-left-rem current-right-rem))
             ;; Option 2: Remove ')'
             (when (> current-right-rem 0)
               (backtrack (+ idx 1) current-str-list open-count current-left-rem (- current-right-rem 1)))]
            [else
             ;; Not a parenthesis
             (backtrack (+ idx 1) (cons char current-str-list) open-count current-left-rem current-right-rem)]))))

    (backtrack 0 '() 0 left-to-remove right-to-remove)
    (hash-keys results)))