#lang racket
(require data/queue)
(require racket/hash)

(define (char->digit c)
  (- (char->integer c) (char->integer #\0)))

(define (digit->char d)
  (integer->char (+ d (char->integer #\0))))

(define (add-a-op s a)
  (let* ((chars (string->list s)))
    (list->string
     (for/list ((char chars)
                (idx (in-naturals)))
       (if (odd? idx)
           (digit->char (modulo (+ (char->digit char) a) 10))
           char)))))

(define (rotate-b-op s b)
  (let* ((len (string-length s))
         (effective-b (modulo b len)))
    (if (= effective-b 0)
        s
        (string-append (substring s (- len effective-b) len)
                       (substring s 0 (- len effective-b))))))

(define (find-lex-smallest-string s a b)
  (let* ((q (make-queue))
         (visited (make-hash)))

    (queue-put! q s)
    (hash-set! visited s #t)

    (let loop ((min-s s))
      (if (queue-empty? q)
          min-s
          (let* ((current-s (queue-get! q))
                 (new-min-s (if (string<? current-s min-s) current-s min-s)))

            (let ((next-s1 (add-a-op current-s a)))
              (when (not (hash-has-key? visited next-s1))
                (hash-set! visited next-s1 #t)
                (queue-put! q next-s1)))

            (let ((next-s2 (rotate-b-op current-s b)))
              (when (not (hash-has-key? visited next-s2))
                (hash-set! visited next-s2 #t)
                (queue-put! q next-s2)))

            (loop new-min-s))))))