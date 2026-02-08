(define (sort-string s)
  (let* ((len (string-length s))
         (counts (make-vector 26 0)))

    ;; Populate character counts
    (for-each (lambda (c)
                (let ((idx (- (char->integer c) (char->integer #\a))))
                  (vector-set! counts idx (+ (vector-ref counts idx) 1))))
              (string->list s))

    ;; Main loop to build the result string
    (let loop ((processed-count 0)
               (result-acc '())) ; Accumulator for characters, built in reverse order
      (if (= processed-count len)
          ;; Base case: all characters processed, reverse and convert to string
          (list->string (reverse result-acc))

          (let-values (((current-result-acc current-processed-count)
                        ;; Increasing pass: iterate from 'a' to 'z'
                        (for/fold ((acc result-acc) (p-count processed-count))
                                  ((i (in-range 0 26)))
                          (if (> (vector-ref counts i) 0)
                              (begin
                                (vector-set! counts i (- (vector-ref counts i) 1))
                                (values (cons (integer->char (+ (char->integer #\a) i)) acc)
                                        (+ p-count 1)))
                              (values acc p-count)))))

            (let-values (((final-result-acc final-processed-count)
                          ;; Decreasing pass: iterate from 'z' to 'a'
                          (for/fold ((acc current-result-acc) (p-count current-processed-count))
                                    ((i (in-range 25 -1 -1)))
                            (if (> (vector-ref counts i) 0)
                                (begin
                                  (vector-set! counts i (- (vector-ref counts i) 1))
                                  (values (cons (integer->char (+ (char->integer #\a) i)) acc)
                                          (+ p-count 1)))
                                (values acc p-count)))))

              ;; Recurse with updated counts and accumulated result
              (loop final-processed-count final-result-acc)))))))