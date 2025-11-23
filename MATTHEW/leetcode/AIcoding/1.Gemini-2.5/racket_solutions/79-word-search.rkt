#lang racket

(require racket/set)

(define/contract (exist board word)
  (-> (listof (listof char?)) string? boolean?)

  (define rows (length board))

  (when (zero? (string-length word))
    #t)

  (when (zero? rows)
    #f)

  (define cols (length (car board)))
  (define word-len (string-length word))

  (when (> word-len (* rows cols))
    #f)

  (define (dfs r c k visited)
    (if (= k word-len)
        #t
        (cond
          ((or (< r 0) (>= r rows) (< c 0) (>= c cols)) #f)
          ((set-member? visited (list r c)) #f)
          ((not (char=? (list-ref (list-ref board r) c) (string-ref word k))) #f)
          (else
           (let ((new-visited (set-add visited (list r c))))
             (or (dfs (+ r 1) c (+ k 1) new-visited)
                 (dfs (- r 1) c (+ k 1) new-visited)
                 (dfs r (+ c 1) (+ k 1) new-visited)
                 (dfs r (- c 1) (+ k 1) new-visited)))))))

  (let loop ((r 0))
    (if (>= r rows)
        #f
        (let loop-inner ((c 0))
          (if (>= c cols)
              (loop (+ r 1))
              (if (char=? (list-ref (list-ref board r) c) (string-ref word 0))
                  (if (dfs r c 0 (set))
                      #t
                      (loop-inner (+ c 1)))
                  (loop-inner (+ c 1)))))))
)