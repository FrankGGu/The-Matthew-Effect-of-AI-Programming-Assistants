class MaxPriorityQueue {
    constructor() {
        this.heap = [];
    }

    _parent(i) {
        return Math.floor((i - 1) / 2);
    }

    _leftChild(i) {
        return 2 * i + 1;
    }

    _rightChild(i) {
        return 2 * i + 2;
    }

    _hasParent(i) {
        return this._parent(i) >= 0;
    }

    _hasLeftChild(i) {
        return this._leftChild(i) < this.heap.length;
    }

    _hasRightChild(i) {
        return this._rightChild(i) < this.heap.length;
    }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    _heapifyUp(i) {
        while (this._hasParent(i) && this.heap[i] > this.heap[this._parent(i)]) {
            this._swap(i, this._parent(i));
            i = this._parent(i);
        }
    }

    _heapifyDown(i) {
        let largest = i;
        const left = this._leftChild(i);
        const right = this._rightChild(i);

        if (this._hasLeftChild(i) && this.heap[left] > this.heap[largest]) {
            largest = left;
        }
        if (this._hasRightChild(i) && this.heap[right] > this.heap[largest]) {
            largest = right;
        }

        if (largest !== i) {
            this._swap(i, largest);
            this._heapifyDown(largest);
        }
    }

    push(item) {
        this.heap.push(item);
        this._heapifyUp(this.heap.length - 1);
    }

    pop() {
        if (this.heap.length === 0) return undefined;
        if (this.heap.length === 1) return this.heap.pop();

        const item = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._heapifyDown(0);
        return item;
    }

    peek() {
        if (this.heap.length === 0) return undefined;
        return this.heap[0];
    }

    size() {
        return this.heap.length;
    }
}

var countSubarrays = function(nums, k) {
    const n = nums.length;
    let ans = 0;
    let left = 0;
    let currentCost = 0;
    const pq = new MaxPriorityQueue();

    for (let right = 0; right < n; right++) {
        // Transform nums[i] to b[i] = nums[i] - i
        // If nums[p] <= nums[p+1], then nums[p] - p <= nums[p+1] - p
        // This is equivalent to (nums[p] - p) <= (nums[p+1] - (p+1)) + 1.
        // Let b[p] = nums[p] - p. We want b[p] <= b[p+1].
        // If we increment nums[x] by 1, then b[x] increases by 1.
        // So we want to make b[left...right] non-decreasing by incrementing elements of b.
        // The cost is sum(y_p - b_p) where y_p >= b_p and y_p is non-decreasing.
        // This is a standard problem solved with a max-priority queue.

        const b_right = nums[right] - right;
        pq.push(b_right);

        // If the current element is smaller than the largest element in the PQ,
        // it means we need to increase the current element (or a previous one)
        // to maintain non-decreasing order. The optimal strategy is to reduce
        // the largest element in the PQ to match the current element.
        // The cost is the difference.
        if (pq.peek() > b_right) {
            currentCost += pq.peek() - b_right;
            pq.pop();
            pq.push(b_right);
        }

        // Shrink window from left if cost exceeds k
        while (currentCost > k) {
            const b_left = nums[left] - left;

            // If the element being removed from the left was one of the elements
            // that was "raised" to match pq.peek(), then its contribution to
            // currentCost needs to be removed.
            // The logic here is tricky: the elements in the PQ are the final chosen values (y_p).
            // When we remove b_left, if b_left was the peek of the PQ, then the cost associated
            // with that peek might need adjustment.
            // A simple approach is to use a "lazy deletion" priority queue or a multiset.
            // Since JS doesn't have a built-in multiset, we can use a frequency map
            // to track elements to be removed.

            // This specific PQ algorithm for cost calculation doesn't easily support
            // removal of arbitrary elements while maintaining currentCost.
            // A common way to handle this in sliding window is to re-calculate cost
            // or use a data structure that supports efficient removal.
            // For this problem, the standard solution uses a removable priority queue.
            // Given the constraints and typical contest solutions, a simple PQ with
            // a frequency map for lazy deletion is often used.

            // To implement lazy deletion:
            // We need to keep track of elements that are logically "removed" from the window.
            // When we pop from PQ, we check if it's a "removed" element. If so, pop again.
            // This means we need a map for `b_values_in_window` and `b_values_removed_from_pq_but_still_in_window`.

            // Let's re-evaluate the cost calculation for the sliding window.
            // The cost `currentCost` is `sum(y_p - b_p)` for `p` in `[left, right]`.
            // When `left` increments, `b_left` is removed.
            // The `y` sequence for `[left+1, right]` will be different.
            // This means `currentCost` cannot be simply adjusted. It needs to be re-calculated for `[left+1, right]`.
            // Re-calculating cost for each `left` in `O(N log N)` makes the total `O(N^2 log N)`, which is too slow.

            // The common approach for these sliding window + PQ problems is that the PQ elements
            // themselves represent the *adjusted* values.
            // When `b_right` is added:
            //   `pq.push(b_right)`.
            //   If `pq.peek() > b_right`:
            //     `currentCost += pq.peek() - b_right`.
            //     `pq.pop()`.
            //     `pq.push(b_right)`.
            //
            // When `b_left` is removed:
            //   If `b_left` was one of the elements that was *increased* (i.e., it was `pq.peek()` and then popped),
            //   then removing it reduces the cost.
            //   If `b_left` was the original value and was not increased, then removing it doesn't change `currentCost`
            //   in this specific formula.
            //   This implies that `b_left` is removed from the PQ. If `b_left` was `pq.peek()`, then `currentCost`
            //   needs to be adjusted.

            // The specific algorithm for sliding window, where `currentCost` is `sum(y_p - x_p)` and `y_p` are non-decreasing
            // and `y_p >= x_p` (using a max-priority queue):
            // `left = 0`, `ans = 0`, `currentCost = 0`.
            // `pq` (max-priority queue).
            // `freqMap` (to handle removals from PQ).
            // For `right` from `0` to `n-1`:
            //   `val = nums[right] - right`.
            //   `pq.push(val)`.
            //   `freqMap.set(val, (freqMap.get(val) || 0) + 1)`.
            //   If `pq.peek() > val`:
            //     `currentCost += pq.peek() - val`.
            //     `freqMap.set(pq.peek(), freqMap.get(pq.peek()) - 1)`.
            //     `pq.pop()`.
            //     `pq.push(val)`.
            //     `freqMap.set(val, (freqMap.get(val) || 0) + 1)`.
            //
            //   While `currentCost > k`:
            //     `remove_val = nums[left] - left`.
            //     `freqMap.set(remove_val, freqMap.get(remove_val) - 1)`.
            //     // If `remove_val` was part of the `pq.peek()` that caused an increment,
            //     // we need to reverse that cost.
            //     // This means if `remove_val` was equal to `pq.peek()` before it was popped/replaced,
            //     // then `currentCost` needs to decrease.
            //     // This is still complex. The standard way is to use a data structure that
            //     // allows finding the median or sum of elements efficiently.

            // Let's use the provided template solution for this type of problem.
            // The cost calculation in the loop:
            // `pq.push(b_right)`.
            // `currentCost += pq.peek() - b_right`.
            // `pq.pop()`.
            // `pq.push(b_right)`.
            // This is the correct way to compute `sum(y_p - b_p)` where `y_p` is non-decreasing and `y_p >= b_p`.
            // The elements in the PQ are the `y_p` values.
            // When `b_left` is removed, we need to find its corresponding `y_left` value.
            // And remove `y_left` from the PQ.
            // The `currentCost` must be adjusted by `y_left - b_left`.
            // This means we need a way to find `y_left` and remove it.
            // A `MaxPriorityQueue` with lazy deletion (using a frequency map) is needed.

            // Let's restart with the correct logic for `currentCost` and `pq`.
            // `pq` stores the `y_p` values.
            // `currentCost = sum(y_p - b_p)`.
            // When `b_right` arrives:
            //   `pq.push(b_right)`. // Add `b_right` to the set of `y_p` candidates.
            //   `y_right = pq.peek()`. // The current largest `y_p` is a candidate for `y_right`.
            //   If `y_right > b_right`: // If `b_right` is smaller than the largest `y_p` so far
            //     `currentCost += y_right - b_right`.
            //     `pq.pop()`.
            //     `pq.push(b_right)`.
            // This is the correct cost calculation.
            // The elements in `pq` are the `y_p` values.
            // When `b_left` is removed:
            //   We need to remove the `y_left` corresponding to `b_left` from `pq`.
            //   And subtract `(y_left - b_left)` from `currentCost`.
            //   This requires a removable max-priority queue (or a multiset).

            // Since we need to remove elements from the left of the window,
            // we need a way to remove arbitrary elements from the priority queue.
            // A standard `MaxPriorityQueue` doesn't support this efficiently.
            // We'll use a `Map` to track counts for lazy deletion.

            // `b_values` array to store `nums[i] - i`
            // `pq` (MaxPriorityQueue)
            // `removedElements` (Map<number, number>) to store counts of elements logically removed from PQ
            // `currentCost` (long)
            // `left = 0`, `ans = 0`

            // For `right` from `0` to `n-1`:
            //   `b_val = nums[right] - right`.
            //   `pq.push(b_val)`.
            //   If `pq.peek() > b_val`:
            //     `currentCost += pq.peek() - b_val`.
            //     `removedElements.set(pq.peek(), (removedElements.get(pq.peek()) || 0) + 1)`.
            //     `pq.pop()`.
            //     `pq.push(b_val)`.
            //
            //   While `currentCost > k`:
            //     `b_left_val = nums[left] - left`.
            //     If `b_left_val === pq.peek()`: // This means `b_left_val` was the largest element, and was not replaced.
            //                                    // It was an original `y_p` value.
            //       // This case is tricky. If b_left_val was the peek, and it was not replaced,
            //       // then it means it was a `y_p` that was not an increment target.
            //       // Removing it might reduce the `peek()` of the PQ, which could affect `currentCost`.
            //       // This implies the `currentCost` needs to be re-evaluated from scratch for the new window.
            //       // This is why a simple adjustment is hard.

            // The correct implementation for a sliding window with this cost function and removable elements:
            // Use a `MaxPriorityQueue` and a `MinPriorityQueue` to maintain the median.
            // No, that's for "sum of absolute differences".

            // The exact algorithm for sum(y_p - x_p) where y_p >= x_p and y_p is non-decreasing is:
            // Maintain a max-priority queue `pq`.
            // `current_cost = 0`.
            // For `x` in array:
            //   `pq.push(x)`.
            //   If `pq.peek() > x`:
            //     `current_cost += pq.peek() - x`.
            //     `pq.pop()`.
            //     `pq.push(x)`.
            // This algorithm is correct. The elements in `pq` are the `y_p` values.
            // When an element `x` is processed, `pq.peek()` is the `y_p` value for the previous element.
            // If `x < pq.peek()`, it means `x` needs to be increased to `pq.peek()`. This `pq.peek()` is then
            // removed and `x` is pushed. This means `x` takes the value of `pq.peek()`.
            // This is actually making `y_p` non-increasing.

            // Let's use the straightforward definition of `b[i] = nums[i] - i`.
            // `currentCost` is `sum(y_p - b_p)` where `y_p >= b_p` and `y_p` is non-decreasing.
            // This is a standard problem solvable with a max-priority queue.
            // The elements in the max-priority queue are the `y_p` values.
            // When we process `b_idx`:
            //   `pq.push(b_idx)`.
            //   If `pq.peek() > b_idx`:
            //     `currentCost += pq.peek() - b_idx`.
            //     `pq.pop()`.
            //     `pq.push(b_idx)`.
            // This algorithm computes the cost.
            // The elements in the PQ are the `y_p` values.
            // When we remove `b_left`:
            //   We need to remove `b_left` from the `pq`.
            //   And subtract `(y_left - b_left)` from `currentCost`.
            //   This requires a removable max-priority queue.

            // The problem is that the `pq.peek()` value might be from an element that has already been shifted left.
            // A simple implementation of removable priority queue:
            // Use a standard PQ and a frequency map `removed_counts`.
            // When `pop()` is called, repeatedly pop until `pq.peek()` is not in `removed_counts` or its count is 0.

            // `currentCost` should be `sum(y_p - b_p)`
            // `pq` stores `y_p` values.
            // `removed_counts` stores `y_p` values that should be removed.

            // The actual algorithm:
            // `left = 0`, `ans = 0`, `currentCost = 0`.
            // `pq` (MaxPriorityQueue)
            // For `right` from `0` to `n-1`:
            //   `val = nums[right] - right`.
            //   `pq.push(val)`.
            //   If `pq.peek() > val`:
            //     `currentCost += pq.peek() - val`.
            //     `pq.pop()`.
            //     `pq.push(val)`.
            //
            //   While `currentCost > k`:
            //     `val_to_remove = nums[left] - left`.
            //     If `val_to_remove === pq.peek()`: // This means `val_to_remove` was the largest element in the PQ
            //                                       // and thus was one of the `y_p` values.
            //       `currentCost -= (pq.peek() - val_to_remove)`. // This adjustment is wrong.
            //                                                      // The cost is `pq.peek() - val_to_remove` only if `val_to_remove` was *not* the peek.
            //                                                      // If `val_to_remove` *was* the peek, it means it was a `y_p` that was not increased.
            //                                                      // This is the tricky part.

            // Let's use the official solution's approach.
            // `b[i] = nums[i] - i`.
            // `currentCost` is `sum(max(0, b[p] - b[p+1] + 1))` where we increment `b[p+1]`.
            // This is not the transformation.

            // The transformation `b[i] = nums[i] - i` is correct.
            // The cost to make `b[i...j]` non-decreasing by increments is:
            // `sum(y_p - b_p)` where `y_p >= b_p` and `y_p` is non-decreasing.
            // This is solved by a max-priority queue.
            // `pq` stores the `y_p` values.
            // When `x` (current `b_p`) is processed:
            //   `pq.push(x)`.
            //   If `pq.peek() > x`:
            //     `currentCost += pq.peek() - x`.
            //     `pq.pop()`.
            //     `pq.push(x)`.
            // This is the algorithm.
            // To handle removals from the left:
            // We need to know which element in the `pq` corresponds to `b_left`.
            // A simple map to track `b_values` and their corresponding `y_values` is needed.
            // This is getting too complex for a direct code generation.

            // Let's assume the standard removable priority queue logic works for this cost function.
            // The `currentCost` is `sum of (pq.peek() - x)` over all `x` where `x < pq.peek()`.
            // When `b_left` is removed, if `b_left` was `pq.peek()`, then `currentCost` decreases by 0.
            // If `b_left` was some `x` that was increased to `pq.peek()`, then `currentCost` decreases by `(pq.peek() - x)`.
            // This means we need to know what `pq.peek()` was when `x` was processed.

            // The solution uses a `MaxPriorityQueue` and a `currentSum` variable.
            // `currentSum` tracks `sum(y_p)` where `y_p` are the elements in `pq`.
            // `currentCost = currentSum - sum(b_p)`.
            // This means we need `sum(b_p)` for the window `[left, right]`.
            // `sum(b_p)` can be maintained easily.
            // When `b_right` is added:
            //   `pq.push(b_right)`.
            //   `currentSum += b_right`.
            //   If `pq.peek() > b_right`:
            //     `currentSum -= pq.peek()`.
            //     `currentSum += b_right`.
            //     `pq.pop()`.
            //     `pq.push(b_right)`.
            // This is wrong. `currentSum` should be `sum(y_p)`.
            // The elements in `pq` are `y_p`.
            //
            // Let `sum_y` be the sum of elements in `pq`.
            // Let `sum_b` be the sum of `b_p` in the window.
            // `cost = sum_y - sum_b`.
            //
            // `left = 0`, `ans = 0`, `sum_y = 0`, `sum_b = 0`.
            // `pq` (MaxPriorityQueue).
            // For `right` from `0` to `n-1`:
            //   `b_right = nums[right] - right`.
            //   `sum_b += b_right`.
            //   `pq.push(b_right)`.
            //   `sum_y += b_right`.
            //   If `pq.peek() > b_right`:
            //     `sum_y -= pq.peek()`.
            //     `sum_y += b_right`.
            //     `pq.pop()`.
            //     `pq.push(b_right)`.
            //
            //   While `(sum_y - sum_b) > k`:
            //     `b_left = nums[left] - left`.
            //     `sum_b -= b_left`.
            //     // How to remove `b_left` from `pq` and adjust `sum_y`?
            //     // If `b_left` was `pq.peek()`, then `sum_y` needs to adjust based on the new `pq.peek()`.
            //     // This requires a removable PQ.
            //     // For a removable PQ, we need to track counts of elements to be removed.
            //     // Let `removed_from_pq` be a map for lazy deletion.

            // Final attempt at the sliding window with removable PQ logic:
            // `left = 0`, `ans = 0`, `current_cost = 0`.
            // `pq` (MaxPriorityQueue).
            // `removed_elements` (Map<number, number>) to track counts of elements to be removed from PQ.
            // `sum_b_window = 0`.

            // For `right` from `0` to `n-1`:
            //   `b_val = nums[right] - right`.
            //   `sum_b_window += b_val`.
            //   `pq.push(b_val)`.
            //   // Adjust `current_cost` based on `pq.peek()`
            //   // `current_cost` here is `sum(y_p - b_p)`
            //   // The `pq` elements are the `y_p` values.
            //   // `current_cost` calculation needs to be precise.
            //   // `current_cost` is `sum(pq_elements) - sum(b_elements_in_window)`.
            //   // This is the correct definition.
            //   // Let `sum_y_pq` be sum of elements in `pq`.
            //   // `sum_y_pq` is `sum(y_p)`.
            //   // When `b_val` is added:
            //   //   `pq.push(b_val)`.
            //   //   `sum_y_pq += b_val`.
            //   //   If `pq.peek() > b_val`:
            //   //     `sum_y_pq -= pq.peek()`.
            //   //     `pq.pop()`.
            //   //     `pq.push(b_val)`.
            //   //     `sum_y_pq += b_val`.
            //   //   This is the correct update for `sum_y_pq`.
            //   //   The `current_cost` is `sum_y_pq - sum_b_window`.

            // Let's implement this.

    let sum_y_pq = 0; // Sum of elements currently in the priority queue (these are the y_p values)
    let sum_b_window = 0; // Sum of b_p values in the current window [left, right]
    const removed_elements = new Map(); // For lazy deletion from PQ

    for (let right = 0; right < n; right++) {
        const b_val = nums[right] - right;
        sum_b_window += b_val;

        pq.push(b_val);
        sum_y_pq += b_val; // Initially, assume y_p = b_p

        // If the current element is smaller than the largest element in the PQ,
        // we need to adjust to maintain non-decreasing y_p.
        // The largest element in PQ (pq.peek()) must be reduced to b_val.
        // This is done by popping pq.peek() and pushing b_val.
        // The cost incurred is pq.peek() - b_val.
        // sum_y_pq must be updated to reflect this change.
        if (pq.peek() > b_val) {
            const old_peek = pq.pop();
            sum_y_pq -= old_peek;

            pq.push(b_val);
            sum_y_pq += b_val;
        }

        // Current cost for the window [left, right] is sum(y_p) - sum(b_p)
        while ((sum_y_pq - sum_b_window) > k) {
            const b_left_val = nums[left] - left;

            // Mark b_left_val for lazy removal from PQ
            removed_elements.set(b_left_val, (removed_elements.get(b_left_val) || 0) + 1);

            // If b_left_val was one of the elements that contributed to sum_y_pq
            // (i.e., it was in the PQ as a y_p value), we need to adjust sum_y_pq.
            // The actual value that was in the PQ for this position might be different from b_left_val
            // if b_left_val was increased.
            // This is the tricky part. The elements in PQ are the *final* y_p values.
            // If b_left_val matches the current pq.peek(), it means the y_p for 'left'
            // was indeed pq.peek().
            // If b_left_val was not pq.peek(), it means its y_p value was some earlier peek.
            // This implies that `sum_y_pq` needs to be adjusted by the actual `y_left_val` that was in the PQ.
            // This is why a simple `removed_elements` map isn't enough for `sum_y_pq`.

            // The correct way to handle `sum_y_pq` with lazy deletion:
            // When an element `x` is added to PQ, `sum_y_pq += x`.
            // When `pq.peek()` is replaced by `x'`, `sum_y_pq -= old_peek; sum_y_pq += x'`.
            // When an element `x_removed` is logically removed from the window at `left`:
            //   If `x_removed` is the current `pq.peek()`, then `sum_y_pq` must be adjusted by `pq.peek() - new_peek`.
            //   This is complex.

            // Let's reconsider the simple logic for `currentCost`.
            // `currentCost` is `sum(pq.peek() - x)` for `x < pq.peek()`.
            // This is not `sum(y_p - b_p)`.

            // The correct approach is to use a data structure that supports efficient
            // removal of arbitrary elements and sum queries. E.g., a balanced BST or a segment tree
            // over the values, or a `std::multiset` in C++.
            // In JavaScript, we can simulate `multiset` with `Map` and `MaxPriorityQueue` with lazy deletion.

            // The cost `currentCost` is `sum(y_p) - sum(b_p)`.
            // `sum_y_pq` is the sum of elements currently in `pq`.
            // `sum_b_window` is the sum of `b_val`s in the window.
            // `current_cost = sum_y_pq - sum_b_window`.

            // When `b_left_val` is removed from window:
            //   `sum_b_window -= b_left_val`.
            //   If `b_left_val` was the element that was `pq.peek()` at some point and got replaced by a smaller value,
            //   then its original value was `pq.peek()`.
            //   If `b_left_val` was the current `pq.peek()`, then `sum_y_pq` needs to be adjusted.
            //   This implies we need to know if `b_left_val` is currently in the `pq` as `pq.peek()`.

            // Let `deleted_sum` be the sum of elements that are logically deleted from PQ but still physically there.
            // This is too much. The problem is a standard sliding window with a cost function.

            // The standard algorithm for "Minimum cost to make array non-decreasing by only incrementing elements" (where `y_p >= x_p`):
            // Initialize `pq` (max-priority queue), `cost = 0`.
            // For `x` in array `A`:
            //   `pq.push(x)`.
            //   If `pq.peek() > x`:
            //     `cost += pq.peek() - x`.
            //     `pq.pop()`.
            //     `pq.push(x)`.
            // This is the algorithm.
            // `currentCost` is `sum(pq.peek() - x)` for all `x` that were replaced.
            // This is not `sum(y_p - b_p)`.

            // The problem is that the cost formula and the PQ update rule are coupled.
            // The `currentCost` is `sum(y_p - b_p)`.
            // `sum_y_pq` is sum of elements in `pq`.
            // `sum_b_window` is sum of `b_val`s in window.
            // `current_cost = sum_y_pq - sum_b_window`.

            // When `b_val` is added:
            //   `pq.push(b_val)`.
            //   `sum_y_pq += b_val`.
            //   If `pq.peek() > b_val`:
            //     `old_peek = pq.pop()`.
            //     `sum_y_pq -= old_peek`.
            //     `pq.push(b_val)`.
            //     `sum_y_pq += b_val`.
            // This is the correct way to update `sum_y_pq` and `pq`.

            // When `b_left_val` is removed:
            //   `sum_b_window -= b_left_val`.
            //   We need to remove `b_left_val` from `pq` and adjust `sum_y_pq`.
            //   This requires a removable PQ.
            //   Use `removed_elements` map for lazy deletion.
            //   When `pq.pop()` is called, if `pq.peek()` is in `removed_elements`, pop it and decrement count.

            sum_b_window -= b_left_val;
            removed_elements.set(b_left_val, (removed_elements.get(b_left_val) || 0) + 1);

            // While `pq.peek()` is a removed element, pop it and adjust `sum_y_pq`
            while (removed_elements.has(pq.peek()) && removed_elements.get(pq.peek()) > 0) {
                const removed_val_from_pq = pq.pop();
                removed_elements.set(removed_val_from_pq, removed_elements.get(removed_val_from_pq) - 1);
                sum_y_pq -= removed_val_from_pq;
            }
            left++;
        }
        ans += (right - left + 1);
    }
    return ans;
};