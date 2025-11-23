(define (max-score-words words letters scores)
  (define (char->index c)
    (- (char->integer c) (char->integer #\a)))

  (define (word-score word)
    (foldl + 0 (map (lambda (c) (list-ref scores (char->index c))) (string->list word))))

  (define (can-form-word? word letter-counts)
    (define word-letter-counts
      (make-vector 26 0))
    (for-each (lambda (c) (vector-set! word-letter-counts (char->index c) (+ (vector-ref word-letter-counts (char->index c)) 1))) (string->list word))

    (let loop ((i 0))
      (cond
        ((= i 26) #t)
        ((> (vector-ref word-letter-counts i) (vector-ref letter-counts i)) #f)
        (else (loop (+ i 1))))))

  (define (solve remaining-words current-letter-counts current-score)
    (cond
      ((null? remaining-words) current-score)
      (else
       (let* ((first-word (car remaining-words))
              (rest-words (cdr remaining-words))
              (word-score (word-score first-word)))
         (if (can-form-word? first-word current-letter-counts)
             (let* ((new-letter-counts (vector-copy current-letter-counts))
                    (word-letter-counts (make-vector 26 0)))
               (for-each (lambda (c) (vector-set! word-letter-counts (char->index c) (+ (vector-ref word-letter-counts (char->index c)) 1))) (string->list first-word))

               (for ((i (in-range 26)))
                 (vector-set! new-letter-counts i (- (vector-ref new-letter-counts i) (vector-ref word-letter-counts i))))

               (max (solve rest-words current-letter-counts current-score)
                    (solve rest-words new-letter-counts (+ current-score word-score))))
             (solve rest-words current-letter-counts current-score))))))

  (define initial-letter-counts
    (make-vector 26 0))
  (for-each (lambda (c) (vector-set! initial-letter-counts (char->index c) (+ (vector-ref initial-letter-counts (char->index c)) 1))) letters)
  (solve words initial-letter-counts 0))