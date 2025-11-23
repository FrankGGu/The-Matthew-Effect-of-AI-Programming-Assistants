(define (cells-in-range s)
  (let* ((start-col-char (string-ref s 0))
         (start-row-char (string-ref s 1))
         (end-col-char (string-ref s 3))
         (end-row-char (string-ref s 4))

         (start-col-int (char->integer start-col-char))
         (end-col-int (char->integer end-col-char))

         (start-row-val (- (char->integer start-row-char) (char->integer #\0)))
         (end-row-val (- (char->integer end-row-char) (char->integer #\0))))

    (for*/list ((col-code (range start-col-int (+ end-col-int 1)))
                (row-val (range start-row-val (+ end-row-val 1))))
      (string (integer->char col-code)
              (integer->char (+ row-val (char->integer #\0)))))))