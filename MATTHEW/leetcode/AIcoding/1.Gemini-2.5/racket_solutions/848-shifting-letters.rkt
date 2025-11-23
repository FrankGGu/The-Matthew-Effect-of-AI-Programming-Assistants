(define (shifting-letters s shifts)
  (let* ((n (string-length s))
         (s-chars (string->list s)))

    (let-values (((suffix-shifts-list current-total-shift)
                  (for/fold ((acc-shifts '()) (current-sum 0))
                            ((i (in-range (- n 1) -1 -1)))
                    (let* ((shift-val (vector-ref shifts i))
                           (new-sum (modulo (+ current-sum shift-val) 26)))
                      (values (cons new-sum acc-shifts) new-sum)))))

      (let ((a-code (char->integer #\a)))
        (list->string
         (for/list ((char-orig (in-list s-chars))
                    (shift-amount (in-list suffix-shifts-list)))
           (let* ((char-code (char->integer char-orig))
                  (shifted-code (modulo (+ (- char-code a-code) shift-amount) 26)))
             (integer->char (+ a-code shifted-code)))))))))