(define (flood-fill image sr sc color)
  (define rows (length image))
  (define cols (length (car image))) ; Assumes image is non-empty and all rows have the same length

  (define original-color (list-ref (list-ref image sr) sc))

  ;; If the new color is the same as the original color, no fill is needed.
  ;; Return the original image (or a deep copy if strict immutability is required,
  ;; but for LeetCode, returning the original reference is usually fine if no changes occur).
  (when (= original-color color)
    (list-copy image)) ; list-copy is not standard. (map (lambda (row) (list-copy row)) image) for deep copy.
                       ; For LeetCode, just 'image' is usually accepted if no change.
                       ; Let's be explicit and return the original image without modification.
                       ; The problem implies returning a new image or the modified one.
                       ; If no change, the original image is the correct result.
                       ; So, we can just return 'image' directly.
                       ; However, the problem expects a list of lists.
                       ; The conversion to vector and back creates a new list of lists anyway.
                       ; So, if original-color == color, we can just return the input 'image'.
    image)

  ;; Convert list of lists to vector of vectors for efficient mutable operations
  (define vec-image (list->vector (map list->vector image)))

  (define (dfs r c)
    ;; Check bounds and if the current pixel's color matches the original color
    (when (and (>= r 0) (< r rows)
               (>= c 0) (< c cols)
               (= (vector-ref (vector-ref vec-image r) c) original-color))

      ;; Set the new color for the current pixel
      (vector-set! (vector-ref vec-image r) c color)

      ;; Recursively call DFS for all four neighbors
      (dfs (+ r 1) c) ; Down
      (dfs (- r 1) c) ; Up
      (dfs r (+ c 1)) ; Right
      (dfs r (- c 1)))) ; Left

  ;; Start the Depth-First Search from the given starting pixel (sr, sc)
  (dfs sr sc)

  ;; Convert the modified vector of vectors back to a list of lists
  (map vector->list (vector->list vec-image)))