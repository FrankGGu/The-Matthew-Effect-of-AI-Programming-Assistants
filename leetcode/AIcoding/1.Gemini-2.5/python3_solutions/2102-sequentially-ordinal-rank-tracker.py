import heapq

class SORTracker:

    def __init__(self):
        # self.smaller: A max-heap. It stores the 'kth_rank' best elements.
        # The element at the root of this max-heap is the 'kth_rank'-th best element.
        # We store tuples of (-score, name) to achieve the desired sorting order:
        # higher score first, then lexicographically smaller name.
        # For a max-heap of (-score, name), the root will be the element with the highest score
        # (smallest -score) and then smallest name.
        self.smaller = [] 

        # self.larger: A min-heap. It stores the remaining elements.
        # The element at the root of this min-heap is the (kth_rank + 1)-th best element.
        # We also store tuples of (-score, name). For a min-heap, the root will be the
        # element with the lowest score (largest -score) and then smallest name.
        self.larger = []

        # self.kth_rank tracks the current rank requested by get().
        # It starts at 0 and increments with each call to get().
        self.kth_rank = 0

    def add(self, name: str, score: int) -> None:
        item = (-score, name)

        # Always add the new item to the 'smaller' heap (max-heap).
        # This heap is meant to hold the 'kth_rank' best elements,
        # so we initially assume the new item might be among the best.
        heapq._heappush_max(self.smaller, item)

        # After adding, 'smaller' might have too many elements or an element that
        # should belong to 'larger'. To maintain the invariant that 'smaller'
        # contains the 'kth_rank' best elements (or 'kth_rank + 1' temporarily
        # after an add operation before a get), we move the 'worst' element
        # from 'smaller' to 'larger'.
        # The 'worst' element in a max-heap is its root (the element with the
        # highest -score and smallest name, which means highest score and smallest name).
        # No, the 'worst' element in a max-heap of (-score, name) is the one that
        # is largest according to the tuple comparison, which means smallest score
        # or largest name if scores are tied. This is what we pop from max-heap.

        # The root of 'smaller' (max-heap) is the best element among those in 'smaller'.
        # The root of 'larger' (min-heap) is the best element among those in 'larger'.
        # We want 'smaller' to contain the 'kth_rank' best elements, and 'larger' the rest.
        # So, all elements in 'smaller' should be better than or equal to all elements in 'larger'.
        # The largest element in 'smaller' (which is `smaller[0]` after `_heappush_max`)
        # should be moved to 'larger' if it's worse than the smallest element in 'larger'.
        # This is the standard balancing act for two heaps.

        # Move the best element from 'smaller' to 'larger' to ensure 'smaller' only contains
        # elements that are truly among the best.
        # The top of 'smaller' (max-heap) is the *best* element (highest score, smallest name).
        # We want to move the *worst* element from 'smaller' to 'larger'.
        # The worst element in a max-heap is the one that would be popped if it were a min-heap.
        # So, we pop the best element from 'smaller' (which is the root of the max-heap)
        # and push it to 'larger'. No, this is wrong.

        # Let's re-evaluate the two-heap strategy for this problem.
        # `self.smaller`: A max-heap of `(-score, name)`. It stores the `self.kth_rank` best items.
        # The *smallest* item in this max-heap is the `self.kth_rank`-th best item.
        # `self.larger`: A min-heap of `(-score, name)`. It stores the remaining items.
        # The *smallest* item in this min-heap is the `(self.kth_rank + 1)`-th best item.

        # When adding:
        # 1. Add `item` to `self.larger` (min-heap).
        # 2. Move the best element from `self.larger` to `self.smaller`.
        #    `heapq._heappush_max(self.smaller, heapq.heappop(self.larger))`
        # 3. If `self.smaller` now has more than `self.kth_rank` elements, move its worst element back to `self.larger`.
        #    The worst element in `self.smaller` (max-heap) is its root.
        #    `if len(self.smaller) > self.kth_rank:`
        #        `heapq.heappush(self.larger, heapq._heappop_max(self.smaller))`

        # This is the correct logic for `add`.
        heapq.heappush(self.larger, item)
        heapq._heappush_max(self.smaller, heapq.heappop(self.larger))

        # Ensure 'smaller' does not exceed the size of 'kth_rank' (which is 0 initially, but will be incremented by get()).
        # This is implicitly handled by the `get()` method.
        # The `add` method should just ensure that `smaller` always contains the `kth_rank` best elements.
        # After an `add`, `smaller` will have `self.kth_rank + 1` elements.
        # The `get` method will then adjust it to `self.kth_rank` elements.

    def get(self) -> str:
        self.kth_rank += 1

        # We need 'smaller' to contain exactly 'self.kth_rank' elements.
        # If 'smaller' has fewer than 'self.kth_rank' elements (which can happen
        # if `add` was called fewer times than `get` or if `smaller` was empty),
        # move the best element from 'larger' to 'smaller'.
        # The best element in 'larger' (min-heap) is its root.
        # This ensures 'smaller' grows to include the next best element.
        while len(self.smaller) < self.kth_rank:
            heapq._heappush_max(self.smaller, heapq.heappop(self.larger))

        # The 'self.kth_rank'-th best element is now at the root of the 'smaller' heap (max-heap).
        # We need to return its name.
        return self.smaller[0][1]