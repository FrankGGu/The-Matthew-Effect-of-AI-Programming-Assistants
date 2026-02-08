func nextPermutation(nums []int) {
	n := len(nums)
	if n <= 1 {
		return
	}

	// Step 1: Find the largest index k such that nums[k] < nums[k+1]
	k := -1
	for i := n - 2; i >= 0; i-- {
		if nums[i] < nums[i+1] {
			k = i
			break
		}
	}

	// If no such index exists, the array is in descending order,
	// which means it is the largest permutation.
	// Reverse the entire array to get the smallest permutation.
	if k == -1 {
		reverse(nums, 0, n-1)
		return
	}

	// Step 2: Find the largest index l greater than k such that nums[k] < nums[l]
	l := -1
	for i := n - 1; i > k; i-- {
		if nums[k] < nums[i] {
			l = i
			break
		}
	}

	// Step 3: Swap nums[k] and nums[l]
	nums[k], nums[l] = nums[l], nums[k]

	// Step 4: Reverse the subarray nums[k+1:]
	reverse(nums, k+1, n-1)
}

func reverse(arr []int, start, end int) {
	for start < end {
		arr[start], arr[end] = arr[end], arr[start]
		start++
		end--
	}
}