package main

func maxTasks(nums []int, tasks []int) int {
	sort.Ints(nums)
	sort.Ints(tasks)

	left, right := 0, len(tasks)
	for left < right {
		mid := (left + right) / 2
		if canAssign(nums, tasks, mid) {
			left = mid + 1
		} else {
			right = mid
		}
	}
	return left
}

func canAssign(nums []int, tasks []int, k int) bool {
	if k == 0 {
		return true
	}
	if len(nums) < k || len(tasks) < k {
		return false
	}

	t := make([]int, k)
	copy(t, tasks[:k])
	sort.Sort(sort.Reverse(sort.IntSlice(t)))

	n := len(nums)
	for i := 0; i < k; i++ {
		if nums[n-k+i] < t[i] {
			return false
		}
	}
	return true
}