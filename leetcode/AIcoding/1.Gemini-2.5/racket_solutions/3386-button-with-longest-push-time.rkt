(define (longest-push-time releaseTimes keysPressed)
  (let* ([keys-list (string->list keysPressed)])
    (let-values ([(max-duration final-result-char prev-release-time-ignored)
                  (for/fold ([current-max-duration 0]
                             [current-result-char #\a] ; Placeholder, will be replaced by the first key
                             [current-prev-release-time 0])
                            ([release-time (in-list releaseTimes)]
                             [key (in-list keys-list)])
                    (let ([duration (- release-time current-prev-release-time)])
                      (cond
                        [(> duration current-max-duration)
                         (values duration key release-time)]
                        [(= duration current-max-duration)
                         (if (char>? key current-result-char)
                             (values current-max-duration key release-time)
                             (values current-max-duration current-result-char release-time))]
                        [else ; (< duration current-max-duration)
                         (values current-max-duration current-result-char release-time)])))])
      final-result-char)))