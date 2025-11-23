#lang racket

(require data/set)

(define (minimum-number-of-people-to-teach n languages friendships)
  (define languages-sets (map list->set languages))

  (define (can-communicate? person-idx1 person-idx2)
    (define langs1 (list-ref languages-sets person-idx1))
    (define langs2 (list-ref languages-sets person-idx2))
    (not (set-empty? (set-intersect langs1 langs2))))

  (define problematic-friendships
    (filter (lambda (f)
              (define u (- (car f) 1))
              (define v (- (cdr f) 1))
              (not (can-communicate? u v))))
            friendships))

  (if (empty? problematic-friendships)
      0
      (begin
        (define min-people (length languages))

        (for ([L (range 1 (add1 n))])
          (define people-who-need-to-learn-L (set))

          (for ([f problematic-friendships])
            (define u (- (car f) 1))
            (define v (- (cdr f) 1))

            (define u-langs (list-ref languages-sets u))
            (define v-langs (list-ref languages-sets v))

            (unless (set-member? u-langs L)
              (set! people-who-need-to-learn-L (set-add people-who-need-to-learn-L u)))

            (unless (set-member? v-langs L)
              (set! people-who-need-to-learn-L (set-add people-who-need-to-learn-L v))))

          (set! min-people (min min-people (set-count people-who-need-to-learn-L))))

        min-people)))