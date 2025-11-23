(define (building-h2o)
  (let ([h-sem (make-semaphore 2)]
        [o-sem (make-semaphore 1)]
        [h-queue (make-channel)]
        [o-queue (make-channel)]
        [h2o-queue (make-channel)])

    (define (hydrogen release)
      (semaphore-wait h-sem)
      (channel-put h-queue release)
      (when (and (> (semaphore-count h-sem) -2) (> (semaphore-count o-sem) -1))
        (channel-get h-queue)
        (channel-get h-queue)
        (channel-get o-queue)
        (release "H")
        (release "H")
        (release "O")
        (semaphore-post o-sem)
        (semaphore-post h-sem)
        (semaphore-post h-sem)
        (channel-put h2o-queue #t)))

    (define (oxygen release)
      (semaphore-wait o-sem)
      (channel-put o-queue release)
      (when (and (> (semaphore-count h-sem) -2) (> (semaphore-count o-sem) -1))
        (channel-get h-queue)
        (channel-get h-queue)
        (channel-get o-queue)
        (release "H")
        (release "H")
        (release "O")
        (semaphore-post o-sem)
        (semaphore-post h-sem)
        (semaphore-post h-sem)
        (channel-put h2o-queue #t)))

    (values hydrogen oxygen)))