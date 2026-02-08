#lang racket

(define (brace-expansion-ii expression)
  (define len (string-length expression))
  (define (char-at idx) (if (< idx len) (stringref expression idx) #f))

  ; Helper to sort a list of strings and remove duplicates
  ; Assumes input list might not be sorted or unique.
  ; Returns a new sorted list with unique elements.
  (define (sort-and-unique lst)
    (let ((sorted-lst (sort lst string<?)))
      (let loop ((res '()) (current sorted-lst))
        (cond
          ((null? current) (reverse res))
          ((null? res) (loop (cons (car current) res) (cdr current)))
          ((string=? (car res) (car current)) (loop res (cdr current)))
          (else (loop (cons (car current) res) (cdr current)))))))

  ; Helper for set union. Assumes l1 and l2 are already sorted and unique.
  ; Returns a new sorted list with unique elements.
  (define (list-union l1 l2)
    (let loop ((res '()) (p1 l1) (p2 l2))
      (cond
        ((null? p1) (append (reverse res) p2))
        ((null? p2) (append (reverse res) p1))
        ((string<? (car p1) (car p2)) (loop (cons (car p1) res) (cdr p1) p2))
        ((string<? (car p2) (car p1)) (loop (cons (car p2) res) p1 (cdr p2)))
        (else (loop (cons (car p1) res) (cdr p1) (cdr p2))))))

  ; Helper for Cartesian product (concatenation).
  ; Assumes l1 and l2 are already sorted and unique.
  ; Returns a new sorted list with unique concatenated strings.
  (define (list-cartesian-product l1 l2)
    (if (or (null? l1) (null? l2))
        '()
        (let ((result (for*/list ((s1 l1) (s2 l2)) (string-append s1 s2))))
          (sort-and-unique result))))

  ; Parser functions. Each function returns (cons result-set new-index).

  ; parse-factor: Handles single letters or braced expressions.
  (define (parse-factor idx)
    (let ((c (char-at idx)))
      (cond
        ((and c (char-lower-case? c)) ; A single lowercase letter
         (cons (list (string c)) (+ idx 1)))
        ((and c (char=? c #\{)) ; A braced expression
         (let* ((expr-res (parse-expression (+ idx 1))) ; Parse the inner expression
                (inner-set (car expr-res))
                (next-idx (cdr expr-res)))
           ; Expect '}' after the inner expression
           (unless (and (char-at next-idx) (char=? (char-at next-idx) #\}))
             (error "Expected '}' at index ~a" next-idx))
           (cons inner-set (+ next-idx 1))))
        (else
         (error (format "Unexpected character or end of string at index ~a: ~a" idx c))))))

  ; parse-term: Handles concatenation of factors.
  (define (parse-term idx)
    (let* ((factor-res (parse-factor idx))
           (current-set (car factor-res))
           (current-idx (cdr factor-res)))
      (let loop ((res-set current-set) (res-idx current-idx))
        (let ((c (char-at res-idx)))
          (cond
            ; If next char is a letter or '{', it's another factor for concatenation
            ((and c (or (char-lower-case? c) (char=? c #\{)))
             (let* ((next-factor-res (parse-factor res-idx))
                    (next-set (car next-factor-res))
                    (next-idx (cdr next-factor-res)))
               (loop (list-cartesian-product res-set next-set) next-idx)))
            (else ; End of term
             (cons res-set res-idx)))))))

  ; parse-expression: Handles union (comma-separated terms).
  (define (parse-expression idx)
    (let* ((term-res (parse-term idx))
           (current-set (car term-res))
           (current-idx (cdr term-res)))
      (let loop ((res-set current-set) (res-idx current-idx))
        (let ((c (char-at res-idx)))
          (cond
            ; If next char is ',', it's a union with another term
            ((and c (char=? c #\,))
             (let* ((next-term-res (parse-term (+ res-idx 1))) ; Skip the comma
                    (next-set (car next-term-res))
                    (next-idx (cdr next-term-res)))
               (loop (list-union res-set next-set) next-idx)))
            (else ; End of expression
             (cons res-set res-idx)))))))

  ; Start parsing from index 0. The final result is the set of words.
  (car (parse-expression 0)))