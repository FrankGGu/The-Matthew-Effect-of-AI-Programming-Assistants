(define (bowlingGame scores)
  (define (calculate-score frames)
    (define (frame-score frame next-frame)
      (if (null? next-frame)
          (car frame)
          (let ((first (car frame))
                (second (cadr frame)))
            (if (= first 10) ; strike
                (+ 10 (car (car next-frame)) (if (null? (cdr (car next-frame))) 0 (cadr (car next-frame))))
                (if (+ first second) ; spare
                    (+ 10 (car (car next-frame)))
                    (+ first second))))))
    (define (helper frames accum)
      (if (null? frames)
          accum
          (let* ((frame (car frames))
                 (next-frame (if (null? (cdr frames)) '() (cdr frames)))
                 (score (frame-score frame next-frame)))
            (helper (cdr frames) (+ accum score)))))
    (helper frames 0))

  (define player1-scores (take scores 10))
  (define player2-scores (drop scores 10))
  (define player1-total (calculate-score player1-scores))
  (define player2-total (calculate-score player2-scores))
  (if (> player1-total player2-total)
      "Player 1"
      (if (< player1-total player2-total)
          "Player 2"
          "Tie")))

(define (take lst n)
  (if (or (null? lst) (zero? n)) '()
      (cons (car lst) (take (cdr lst) (sub1 n)))))

(define (drop lst n)
  (if (or (null? lst) (zero? n)) lst
      (drop (cdr lst) (sub1 n))))