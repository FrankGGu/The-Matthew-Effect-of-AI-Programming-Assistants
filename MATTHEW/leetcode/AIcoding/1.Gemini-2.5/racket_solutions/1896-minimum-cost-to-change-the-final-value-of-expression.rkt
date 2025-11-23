#lang racket

(define (min-cost-to-change-final-value-of-expression s)
  (define n (string-length s))

  ;; parse-operand parses a single '0', '1', or a parenthesized expression.
  ;; Returns (list cost-to-make-0 cost-to-make-1 next-idx)
  (define (parse-operand idx)
    (cond
      ((char=? (string-ref s idx) #\0) (list 0 1 (+ idx 1)))
      ((char=? (string-ref s idx) #\1) (list 1 0 (+ idx 1)))
      ((char=? (string-ref s idx) #\()
       (let* ((result (parse-expression (+ idx 1)))
              (cost-0 (car result))
              (cost-1 (cadr result))
              (next-idx (caddr result)))
         ;; Consume the closing parenthesis
         (list cost-0 cost-1 (+ next-idx 1))))
      (else (error "Invalid character in parse-operand"))))

  ;; parse-expression parses an expression, possibly involving an operator.
  ;; Returns (list cost-to-make-0 cost-to-make-1 next-idx)
  (define (parse-expression idx)
    (let* ((left-result (parse-operand idx))
           (l0 (car left-result))
           (l1 (cadr left-result))
           (current-idx (caddr left-result)))

      (if (or (= current-idx n) (char=? (string-ref s current-idx) #\)))
          ;; If no operator, it's just the operand itself (e.g., "0", "1", "(0)", "((1))")
          (list l0 l1 current-idx)
          ;; Otherwise, there's an operator and a right operand
          (let* ((op-char (string-ref s current-idx))
                 (right-result (parse-operand (+ current-idx 1)))
                 (r0 (car right-result))
                 (r1 (cadr right-result))
                 (next-idx (caddr right-result)))

            (let ((res-cost-0 0) (res-cost-1 0))
              (cond
                ;; Case 1: Operator is '&'
                ((char=? op-char #\&)
                 ;; Option A: Keep '&'
                 (set! res-cost-0 (min (+ l0 r0) (+ l0 r1) (+ l1 r0)))
                 (set! res-cost-1 (+ l1 r1))
                 ;; Option B: Change '&' to '|' (cost +1)
                 (let ((changed-op-cost-0 (+ (+ l0 r0) 1))
                       (changed-op-cost-1 (+ (min (+ l1 r1) (+ l1 r0) (+ l0 r1)) 1)))
                   (set! res-cost-0 (min res-cost-0 changed-op-cost-0))
                   (set! res-cost-1 (min res-cost-1 changed-op-cost-1))))

                ;; Case 2: Operator is '|'
                ((char=? op-char #\|)
                 ;; Option A: Keep '|'
                 (set! res-cost-0 (+ l0 r0))
                 (set! res-cost-1 (min (+ l1 r1) (+ l1 r0) (+ l0 r1)))
                 ;; Option B: Change '|' to '&' (cost +1)
                 (let ((changed-op-cost-0 (+ (min (+ l0 r0) (+ l0 r1) (+ l1 r0)) 1))
                       (changed-op-cost-1 (+ (+ l1 r1) 1)))
                   (set! res-cost-0 (min res-cost-0 changed-op-cost-0))
                   (set! res-cost-1 (min res-cost-1 changed-op-cost-1))))

                (else (error "Invalid operator character"))
                )
              (list res-cost-0 res-cost-1 next-idx))))))

  (let* ((final-result (parse-expression 0))
         (cost-0 (car final-result))
         (cost-1 (cadr final-result)))
    (min cost-0 cost-1)))