(define (char-lower-case-letter? c)
  (and (char>=? c #\a) (char<=? c #\z)))

(define (char-digit? c)
  (and (char>=? c #\0) (char<=? c #\9)))

(define (char-hyphen? c)
  (char=? c #\-))

(define (char-punctuation? c)
  (or (char=? c #\.)
      (char=? c #\!)
      (char=? c #\,)))

(define (is-valid-word? s)
  (let* ((len (string-length s)))
    (cond
      ((zero? len) #f)
      (else
       (let loop ((idx 0)
                  (hyphen-count 0)
                  (punctuation-count 0))
         (cond
           ((= idx len)
            #t)
           (else
            (let ((c (string-ref s idx)))
              (cond
                ((char-digit? c) #f)
                ((char-lower-case-letter? c)
                 (loop (+ idx 1) hyphen-count punctuation-count))
                ((char-hyphen? c)
                 (cond
                   ((> punctuation-count 0) #f)
                   ((> hyphen-count 0) #f)
                   ((or (= idx 0) (= idx (- len 1))) #f)
                   (else
                    (let ((prev-c (string-ref s (- idx 1)))
                          (next-c (string-ref s (+ idx 1))))
                      (if (and (char-lower-case-letter? prev-c) (char-lower-case-letter? next-c))
                          (loop (+ idx 1) (+ hyphen-count 1) punctuation-count)
                          #f))))
                ((char-punctuation? c)
                 (cond
                   ((> punctuation-count 0) #f)
                   ((not (= idx (- len 1))) #f)
                   (else
                    (loop (+ idx 1) hyphen-count (+ punctuation-count 1)))))
                (else #f))))))))))

(define (count-valid-words sentence)
  (let* ((words (string-split sentence #\space))
         (non-empty-words (filter (lambda (s) (> (string-length s) 0)) words))
         (valid-words (filter is-valid-word? non-empty-words)))
    (length valid-words)))