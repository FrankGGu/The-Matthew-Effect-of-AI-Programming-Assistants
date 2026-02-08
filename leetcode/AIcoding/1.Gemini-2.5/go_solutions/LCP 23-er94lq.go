package main

import "sort"

func nextPermutation(nums []int) {
	n := len(nums)
	if n <= 1 {
		return
	}

	k := -1
	for i := n - 2; i >= 0; i-- {
		if nums[i] < nums[i+1] {
			k = i
			break
		}
	}

	if k == -1 {
		reverse(nums)
		return
	}

	l := -1
	for i := n - 1; i > k; i-- {
		if nums[k] < nums[i] {
			l = i
			break
		}
	}

	nums[k], nums[l] = nums[l], nums[k]

	reverse(nums[k+1:])
}

func reverse(arr []int) {
	i, j := 0, len(arr)-1
	for i < j {
		arr[i], arr[j] = arr[j], arr[i]
		i++
		j--
	}
}