#lang racket

(define (make-nested-integer-integer val)
  (list 'integer val))

(define (make-nested-integer-list children)
  (list 'list children))

(define (nested-integer-is-integer? ni)
  (eq? (car ni) 'integer))

(define (nested-integer-get-integer ni)
  (if (nested-integer-is-integer? ni)
      (cadr ni)
      (error "Not an integer NestedInteger")))

(define (nested-integer-get-list ni)
  (if (not (nested-integer-is-integer? ni))
      (cadr ni)
      (error "Not a list NestedInteger")))

(define (deserialize s)
  (let ((len (string-length s)))

    ;; parse-integer-val: Parses an integer from the string starting at idx.
    ;; Returns (cons NestedInteger next-index).
    (define (parse-integer-val idx)
      (let loop ((current-idx idx)
                 (num-str ""))
        (if (< current-idx len)
            (let ((char (string-ref s current-idx)))
              (if (or (char-numeric? char) (and (char=? char #\-) (string=? num-str "")))
                  (loop (+ current-idx 1) (string-append num-str (string char)))
                  (cons (make-nested-integer-integer (string->number num-str)) current-idx)))
            (cons (make-nested-integer-integer (string->number num-str)) current-idx))))

    ;; parse-element: Parses a NestedInteger (either integer or list) from the string starting at idx.
    ;; Returns (cons NestedInteger next-index).
    (define (parse-element idx)
      (cond
        ;; Case 1: Integer (starts with a digit or a minus sign)
        ((or (char-numeric? (string-ref s idx)) (char=? (string-ref s idx) #\-))
         (parse-integer-val idx))

        ;; Case 2: List (starts with '[')
        ((char=? (string-ref s idx) #\[)
         ;; Recursively parse elements within the list
         (let loop ((current-idx (+ idx 1)) ; Move past '['
                    (elements-acc '()))     ; Accumulator for list elements
           (cond
             ;; End of list (empty list or after last element)
             ((char=? (string-ref s current-idx) #\])
              (cons (make-nested-integer-list (reverse elements-acc)) (+ current-idx 1)))

             ;; Parse an element
             (else
              (let* ((parsed-element-pair (parse-element current-idx))
                     (element (car parsed-element-pair))
                     (next-idx (cdr parsed-element-pair)))
                (cond
                  ;; After an element, expect either a comma or a closing bracket
                  ((char=? (string-ref s next-idx) #\,)
                   (loop (+ next-idx 1) (cons element elements-acc)))
                  ((char=? (string-ref s next-idx) #\])
                   (cons (make-nested-integer-list (reverse (cons element elements-acc))) (+ next-idx 1)))
                  (else
                   (error "Unexpected character after element: " (string-ref s next-idx))))))))
        (else
         (error "Unexpected character at index " idx ": " (string-ref s idx))))))

    ;; Start parsing from the beginning of the string
    (car (parse-element 0))))