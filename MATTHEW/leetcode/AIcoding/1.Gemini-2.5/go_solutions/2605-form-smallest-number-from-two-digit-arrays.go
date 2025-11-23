package main

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func formSmallestNumber(nums1 []int, nums2 []int) int {
	has1 := make([]bool, 10)
	has2 := make([]bool, 10)

	min1 := 10
	for _, n := range nums1 {
		has1[n] = true
		if n < min1 {
			min1 = n
		}
	}

	min2 := 10
	for _, n := range nums2 {
		has2[n] = true
		if n < min2 {
			min2 = n
		}
	}

	smallestCommon := -1

	for i := 1; i <= 9; i++ {
		if has1[i] && has2[i] {
			smallestCommon = i
			break
		}
	}

	smallestTwoDigit := min(min1, min2)*10 + max(min1, min2)

	if smallestCommon != -1 {
		return min(smallestCommon, smallestTwoDigit)
	} else {
		return smallestTwoDigit
	}
}