(define/contract (reformat s)
  (-> string? string?)
  (let* ((digits (filter char-numeric? (string->list s)))
         (letters (filter char-alphabetic? (string->list s)))
         (diff (- (length digits) (length letters))))
    (cond
      ((> (abs diff) 1) "")
      (else
       (let ((longer (if (> diff 0) digits letters))
             (shorter (if (> diff 0) letters digits)))
         (list->string
          (apply append
                 (map list
                      (if (> diff 0) longer shorter)
                      (if (> diff 0) shorter longer))))))))