(struct FrontMiddleBackQueue ()
  (front-list back-list)
  #:mutable
  #:transparent)

(define (make-FrontMiddleBackQueue)
  (FrontMiddleBackQueue '() '()))

(define (push-front q val)
  (let ([front (FrontMiddleBackQueue-front-list q)]
        [back (FrontMiddleBackQueue-back-list q)])
    (set-FrontMiddleBackQueue-front-list! q (cons val front))
    (balance q)))

(define (push-middle q val)
  (let ([front (FrontMiddleBackQueue-front-list q)]
        [back (FrontMiddleBackQueue-back-list q)])
    (if (> (length front) (length back))
        (let ([mid (car (reverse front))])
          (set-FrontMiddleBackQueue-front-list! q (reverse (cons val (cdr (reverse front)))))
        (set-FrontMiddleBackQueue-back-list! q (cons val back)))
    (balance q)))

(define (push-back q val)
  (let ([front (FrontMiddleBackQueue-front-list q)]
        [back (FrontMiddleBackQueue-back-list q)])
    (set-FrontMiddleBackQueue-back-list! q (append back (list val)))
    (balance q)))

(define (pop-front q)
  (let ([front (FrontMiddleBackQueue-front-list q)]
        [back (FrontMiddleBackQueue-back-list q)])
    (if (null? front)
        (if (null? back)
            -1
            (let ([val (car back)])
              (set-FrontMiddleBackQueue-back-list! q (cdr back))
              val))
        (let ([val (car front)])
          (set-FrontMiddleBackQueue-front-list! q (cdr front))
          (balance q)
          val))))

(define (pop-middle q)
  (let ([front (FrontMiddleBackQueue-front-list q)]
        [back (FrontMiddleBackQueue-back-list q)])
    (cond [(and (null? front) (null? back)) -1]
          [(>= (length front) (length back))
           (let ([val (car (reverse front))])
             (set-FrontMiddleBackQueue-front-list! q (reverse (cdr (reverse front))))
             val)]
          [else
           (let ([val (car back)])
             (set-FrontMiddleBackQueue-back-list! q (cdr back))
             val)]))))

(define (pop-back q)
  (let ([front (FrontMiddleBackQueue-front-list q)]
        [back (FrontMiddleBackQueue-back-list q)])
    (if (null? back)
        (if (null? front)
            -1
            (let ([val (car (reverse front))])
              (set-FrontMiddleBackQueue-front-list! q (reverse (cdr (reverse front))))
              val))
        (let ([val (last back)])
          (set-FrontMiddleBackQueue-back-list! q (drop-right back 1))
          val))))

(define (balance q)
  (let ([front (FrontMiddleBackQueue-front-list q)]
        [back (FrontMiddleBackQueue-back-list q)])
    (let ([front-len (length front)]
          [back-len (length back)])
      (cond [(> front-len (+ back-len 1))
              (let ([new-front (take front (quotient (+ front-len back-len) 2))]
                    [new-back (append (drop front (quotient (+ front-len back-len) 2)) back)])
                (set-FrontMiddleBackQueue-front-list! q new-front)
                (set-FrontMiddleBackQueue-back-list! q new-back))]
            [(> back-len front-len)
             (let ([split (quotient (+ front-len back-len) 2)]
                   [new-front (append front (take back (- split front-len)))]
                   [new-back (drop back (- split front-len))])
               (set-FrontMiddleBackQueue-front-list! q new-front)
               (set-FrontMiddleBackQueue-back-list! q new-back))]))))