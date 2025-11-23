package main

func goodDaysToRobBank(security []int, time int) []int {
	n := len(security)
	if n == 0 {
		return []int{}
	}

	left := make([]int, n)
	for i := 1; i < n; i++ {
		if security[i-1] >= security[i] {
			left[i] = left[i-1] + 1
		} else {
			left[i] = 0
		}
	}

	right := make([]int, n)
	for i := n - 2; i >= 0; i-- {
		if security[i] <= security[i+1] {
			right[i] = right[i+1] + 1
		} else {
			right[i] = 0
		}
	}

	var ans []int
	for i := 0; i < n; i++ {
		if left[i] >= time && right[i] >= time {
			ans = append(ans, i)
		}
	}

	return ans
}