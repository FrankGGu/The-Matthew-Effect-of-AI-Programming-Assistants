import (
	"container/heap"
	"math"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] } // Min-heap
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x any) {
	*h = append(*h, x.(int))
}

func (h *IntHeap) Pop() any {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func earliestSecondToMarkIndices(nums []int, changeOperations [][]int) int {
	n := len(nums)
	m := len(changeOperations)

	// check function: determines if it's possible to mark all n indices by second `t`.
	// `t` represents the maximum second a changeOperation can be applied.
	// If `t=0`, no changeOperations can be applied.
	check := func(t int) bool {
		// last_op_pos[i] stores the index `k` of the latest changeOperations[k]
		// that affects index `i` and `k+1 <= t`.
		// If no such operation, it remains -1.
		last_op_pos := make([]int, n)
		for i := 0; i < n; i++ {
			last_op_pos[i] = -1
		}

		// Iterate through available change operations up to time `t`.
		// `changeOperations[k]` is applied at second `k+1`.
		// So `k+1 <= t` means `k <= t-1`.
		for k := 0; k < m && k <= t-1; k++ {
			idx := changeOperations[k][0]
			last_op_pos[idx] = k
		}

		// values_to_pay stores the costs for indices that must be marked by spending seconds.
		// These operations do not consume a time slot.
		values_to_pay := make([]int, 0)

		// pq is a min-heap for `nums[i]` values of indices that *could* be marked for free
		// using a changeOperation (val=0), but we might choose to pay for them if we run out of slots.
		pq := &IntHeap{}
		heap.Init(pq)

		for i := 0; i < n; i++ {
			if last_op_pos[i] == -1 {
				// No changeOperation affects this index up to time `t`.
				// Must mark by spending its current value.
				values_to_pay = append(values_to_pay, nums[i])
			} else {
				k := last_op_pos[i]
				val := changeOperations[k][1]
				if val == 0 {
					// This index `i` can be marked for free using changeOperations[k] at time `k+1`.
					// This operation consumes one time slot.
					// We add `nums[i]` to the heap. This represents the cost if we *don't* use the free operation
					// for this index (e.g., because we run out of time slots, or prefer to use the slot for another index).
					heap.Push(pq, nums[i])
				} else {
					// changeOperations[k] changes nums[i] to `val`.
					// We must mark `i` by spending `min(original nums[i], val)`.
					// This operation does not consume a time slot.
					values_to_pay = append(values_to_pay, min(nums[i], val))
				}
			}
		}

		// Now, we have `len(values_to_pay)` indices that are decided to be marked by paying.
		// We have `pq.Len()` indices that are candidates for free marks (each consuming 1 time slot).
		// We have `t` total time slots available for `changeOperations`.
		// We can mark at most `t` indices for free using `changeOperations`.

		num_free_candidates := pq.Len()
		num_to_mark_for_free := min(num_free_candidates, t) // Number of indices we can mark for free using slots.
		num_to_pay_from_pq := num_free_candidates - num_to_mark_for_free // Remaining free candidates that we must pay for.

		// Pop the smallest `num_to_pay_from_pq` values from the heap and add them to `values_to_pay`.
		// These are the indices we *would* have marked for free, but couldn't due to slot limits,
		// and they are the cheapest to pay for.
		for i := 0; i < num_to_pay_from_pq; i++ {
			values_to_pay = append(values_to_pay, heap.Pop(pq).(int))
		}

		// Total indices marked:
		// 1. Those in `values_to_pay` (marked by spending seconds).
		// 2. Those `num_to_mark_for_free` indices (marked for free using time slots).
		total_marked := len(values_to_pay) + num_to_mark_for_free

		return total_marked == n
	}

	// Binary search for the earliest second `t`.
	// The range for `t` is from 0 to `m`.
	// `t=0` means no change operations are used.
	// `t=m` means all change operations are available.
	low := 0
	high := m
	ans := -1

	for low <= high {
		mid := low + (high-low)/2
		if check(mid) {
			ans = mid
			high = mid - 1
		} else {
			low = mid + 1
		}
	}

	return ans
}