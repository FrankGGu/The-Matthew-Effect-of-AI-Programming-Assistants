#lang racket

(require racket/hash)

(define (solve s answers)
  ;; 1. Parse s into numbers and operators
  (define (parse-expression s)
    (let loop ((chars (string->list s)) (current-num 0) (nums '()) (ops '()) (parsing-num #t))
      (cond
        ((null? chars)
         (values (reverse (cons current-num nums)) (reverse ops)))
        ((char-numeric? (car chars))
         (loop (cdr chars)
               (+ (* current-num 10) (- (char->integer (car chars)) (char->integer #\0)))
               nums ops #t))
        (else ;; operator
         (loop (cdr chars)
               0
               (cons current-num nums)
               (cons (car chars) ops)
               #f)))))
  (define-values (nums ops) (parse-expression s))
  (define N (length nums))

  ;; 2. Calculate actual_value (with precedence)
  (define (calculate-actual nums ops)
    (let* ((temp-nums '())
           (temp-ops '())
           (num-list nums)
           (op-list ops))

      ;; First pass: handle multiplications
      (set! temp-nums (list (car num-list)))
      (set! num-list (cdr num-list))
      (let loop-mult ((current-ops op-list))
        (unless (null? current-ops)
          (let ((op (car current-ops))
                (num (car num-list)))
            (cond
              ((char=? op #\*)
               (set! temp-nums (cons (* (car temp-nums) num) (cdr temp-nums)))
               (set! num-list (cdr num-list)))
              (else ;; #\+
               (set! temp-nums (cons num temp-nums))
               (set! temp-ops (cons op temp-ops))
               (set! num-list (cdr num-list))))
            (loop-mult (cdr current-ops)))))

      ;; Second pass: handle additions
      (define current-sum (car temp-nums))
      (let loop-add ((remaining-nums (cdr temp-nums)) (remaining-ops temp-ops))
        (unless (null? remaining-ops)
          (set! current-sum (+ current-sum (car remaining-nums)))
          (loop-add (cdr remaining-nums) (cdr remaining-ops))))
      current-sum))

  (define actual-value (calculate-actual nums ops))

  ;; 3. Calculate all_possible_values (DP with 1001 cap)
  ;; dp[i][j] stores a hash-set of possible values for nums[i]...nums[j]
  (define dp (make-vector N))
  (for ((i (range N)))
    (vector-set! dp i (make-vector N)))

  (for ((i (range N)))
    (vector-set! (vector-ref dp i) i (hash-set (list-ref nums i))))

  (for ((len (range 2 (+ N 1)))) ;; len is number of numbers in sub-expression
    (for ((i (range (- N len) -1 -1))) ;; i from N-len down to 0
      (define j (+ i len -1))
      (define current-set (hash-set))
      (for ((m (range i j))) ;; m is the split point, op is ops[m]
        (define op (list-ref ops m))
        (define left-values (vector-ref (vector-ref dp i) m))
        (define right-values (vector-ref (vector-ref dp (+ m 1)) j))
        (hash-set-for-each
         left-values
         (lambda (val1)
           (hash-set-for-each
            right-values
            (lambda (val2)
              (define res (if (char=? op #\+) (+ val1 val2) (* val1 val2)))
              (hash-set-add! current-set (if (> res 1000) 1001 res)))))))
      (vector-set! (vector-ref dp i) j current-set)))

  (define all-possible-values (vector-ref (vector-ref dp 0) (- N 1)))

  ;; 4. Score students
  (define total-score 0)
  (for ((student-answer answers))
    (cond
      ((= student-answer actual-value)
       (set! total-score (+ total-score 5)))
      ((hash-set-contains? all-possible-values student-answer)
       (set! total-score (+ total-score 2)))))

  total-score)