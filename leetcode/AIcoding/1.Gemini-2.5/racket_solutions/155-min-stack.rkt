(struct min-stack (elements) #:mutable)

(define (min-stack-init)
  (min-stack '()))

(define (min-stack-push s val)
  (let* ([current-elements (min-stack-elements s)]
         [min-so-far (if (empty? current-elements)
                         val
                         (min val (cdr (car current-elements))))]
         [new-element (cons val min-so-far)])
    (set-min-stack-elements! s (cons new-element current-elements))))

(define (min-stack-pop s)
  (set-min-stack-elements! s (cdr (min-stack-elements s))))

(define (min-stack-top s)
  (car (car (min-stack-elements s))))

(define (min-stack-get-min s)
  (cdr (car (min-stack-elements s))))