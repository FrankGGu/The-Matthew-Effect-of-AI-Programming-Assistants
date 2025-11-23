#lang racket

(define (count-of-atoms formula)
  (let* ([n (string-length formula)]
         [idx (box 0)]
         [stack (list (make-hash))])

    (define (read-element-name)
      (let* ([start-idx (unbox idx)])
        (set-box! idx (+ (unbox idx) 1))
        (let loop ()
          (if (and (< (unbox idx) n) (char-lower-case? (string-ref formula (unbox idx))))
              (begin
                (set-box! idx (+ (unbox idx) 1))
                (loop))
              (substring formula start-idx (unbox idx))))))

    (define (read-number)
      (let* ([start-idx (unbox idx)])
        (let loop ()
          (if (and (< (unbox idx) n) (char-numeric? (string-ref formula (unbox idx))))
              (begin
                (set-box! idx (+ (unbox idx) 1))
                (loop))
              (let ([num-str (substring formula start-idx (unbox idx))])
                (if (string=? num-str "")
                    1
                    (string->number num-str)))))))

    (let loop ()
      (when (< (unbox idx) n)
        (let ([char (string-ref formula (unbox idx))])
          (cond
            [(char=? char #\()
             (set-box! idx (+ (unbox idx) 1))
             (set! stack (cons (make-hash) stack))]
            [(char=? char #\))
             (set-box! idx (+ (unbox idx) 1))
             (let* ([current-map (car stack)]
                    [multiplier (read-number)]
                    [prev-map (cadr stack)])
               (set! stack (cdr stack))
               (hash-for-each
                current-map
                (lambda (elem count)
                  (let ([new-count (* count multiplier)])
                    (hash-set! prev-map elem (+ new-count (hash-ref prev-map elem 0)))))))]
            [(char-upper-case? char)
             (let* ([element (read-element-name)]
                    [count (read-number)]
                    [current-map (car stack)])
               (hash-set! current-map element (+ count (hash-ref current-map element 0))))]))
        (loop)))

    (let* ([final-counts (car stack)]
           [sorted-elements (sort (hash-keys final-counts) string<?)])
      (apply string-append
             (map (lambda (elem)
                    (let ([count (hash-ref final-counts elem)])
                      (if (= count 1)
                          elem
                          (string-append elem (number->string count)))))
                  sorted-elements)))))