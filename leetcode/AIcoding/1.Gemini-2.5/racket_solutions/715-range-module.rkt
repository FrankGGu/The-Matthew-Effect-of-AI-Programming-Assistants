#lang racket

(define-struct range-module (intervals) #:mutable)

(define (make-range-module)
  (range-module '()))

(define (min a b) (if (< a b) a b))
(define (max a b) (if (> a b) a b))

(define (range-module-add-range rm start end)
  (let* ((old-intervals (range-module-intervals rm)))
    (let-values (((before-list after-list merged-s merged-e)
                  (foldl (lambda (interval acc-vals)
                           (let* ((rs (car interval))
                                  (re (cdr interval))
                                  (current-before (car acc-vals))
                                  (current-after (cadr acc-vals))
                                  (current-s (caddr acc-vals))
                                  (current-e (cadddr acc-vals)))
                             (cond
                               ((<= re current-s)
                                (list (cons interval current-before) current-after current-s current-e))
                               ((>= rs current-e)
                                (list current-before (cons interval current-after) current-s current-e))
                               (else
                                (list current-before current-after (min current-s rs) (max current-e re))))))
                         (list '() '() start end)
                         old-intervals)))
      (set-range-module-intervals! rm
                                   (append (reverse before-list)
                                           (list (cons merged-s merged-e))
                                           (reverse after-list))))))

(define (range-module-remove-range rm start end)
  (let* ((old-intervals (range-module-intervals rm)))
    (let ((final-intervals
           (foldl (lambda (interval acc)
                    (let ((rs (car interval))
                          (re (cdr interval)))
                      (cond
                        ((or (>= rs end) (<= re start))
                         (cons interval acc))
                        (else
                         (let ((temp-acc acc))
                           (when (> re end)
                             (set! temp-acc (cons (cons end re) temp-acc)))
                           (when (< rs start)
                             (set! temp-acc (cons (cons rs start) temp-acc)))
                           temp-acc))))
                  '() old-intervals)))
      (set-range-module-intervals! rm (reverse final-intervals)))))

(define (range-module-query-range rm start end)
  (let ((intervals (range-module-intervals rm)))
    (let loop ((current-intervals intervals)
               (current-covered-start start))
      (cond
        ((>= current-covered-start end) #t)
        ((empty? current-intervals) #f)
        (else
         (let* ((rs (car (car current-intervals)))
                (re (cdr (car current-intervals))))
           (cond
             ((>= rs current-covered-start)
              #f)
             ((> re current-covered-start)
              (loop (cdr current-intervals) (max current-covered-start re)))
             (else
              (loop (cdr current-intervals) current-covered-start))))))))