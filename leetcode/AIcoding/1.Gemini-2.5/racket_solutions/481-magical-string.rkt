(define (magical-string n)
  (cond
    ((= n 0) 0)
    ((= n 1) 1)
    ((= n 2) 1)
    (else
     (let* ((s (make-vector n)) ; s will store the magical string
            (head 2) ; Index for reading the count from s
            (tail 3) ; Index for writing to s
            (ones-count 1)) ; Count of 1s in the first n characters
       ;; Initialize the first few elements of s
       ;; S starts with "122"
       (vector-set! s 0 1)
       (vector-set! s 1 2)
       (vector-set! s 2 2)

       ;; Loop to generate the rest of the string up to n characters
       (let loop ()
         (when (< tail n)
           ;; The number of times to append is s[head]
           (let* ((count (vector-ref s head))
                  ;; Determine the value to append: it alternates.
                  ;; If the last character written was 1, the next is 2. If 2, the next is 1.
                  (last-written-char (vector-ref s (- tail 1)))
                  (next-char-to-append (if (= last-written-char 1) 2 1)))

             (for ([i (in-range count)])
               (when (< tail n) ; Make sure we don't exceed n characters
                 (vector-set! s tail next-char-to-append)
                 (when (= next-char-to-append 1)
                   (set! ones-count (+ ones-count 1)))
                 (set! tail (+ tail 1)))))
           (set! head (+ head 1)) ; Move head pointer to the next count
           (loop))))
       ones-count))))