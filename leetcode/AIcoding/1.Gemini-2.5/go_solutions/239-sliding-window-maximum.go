package main

import (
	"container/list"
)

func maxSlidingWindow(nums []int, k int) []int {
	if len(nums) == 0 || k == 0 {
		return []int{}
	}

	res := make([]int, 0, len(nums)-k+1)
	dq := list.New() // Stores indices

	for i := 0; i < len(nums); i++ {
		// Remove elements from front that are out of window
		if dq.Len() > 0 && dq.Front().Value.(int) <= i-k {
			dq.Remove(dq.Front())
		}

		// Remove elements from back that are smaller than or equal to current
		// This maintains the decreasing order property in the deque
		for dq.Len() > 0 && nums[dq.Back().Value.(int)] <= nums[i] {
			dq.Remove(dq.Back())
		}

		// Add current element's index to back
		dq.PushBack(i)

		// If window is fully formed, append maximum to result
		if i >= k-1 {
			res = append(res, nums[dq.Front().Value.(int)])
		}
	}

	return res
}