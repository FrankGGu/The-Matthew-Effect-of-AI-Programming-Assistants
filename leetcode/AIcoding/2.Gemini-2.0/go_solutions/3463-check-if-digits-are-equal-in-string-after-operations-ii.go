func areSimilar(nums []int, k int) bool {
	n := len(nums)
	odd := []int{}
	even := []int{}
	for i := 0; i < n; i++ {
		if nums[i]%2 == 0 {
			even = append(even, nums[i])
		} else {
			odd = append(odd, nums[i])
		}
	}

	odd2 := []int{}
	even2 := []int{}

	for i := 0; i < n; i++ {
		idx := (i + k) % n
		if nums[idx]%2 == 0 {
			even2 = append(even2, nums[idx])
		} else {
			odd2 = append(odd2, nums[idx])
		}
	}

	if len(odd) != len(odd2) || len(even) != len(even2) {
		return false
	}

	for i := 0; i < len(odd); i++ {
		if odd[i] != odd2[i] {
			return false
		}
	}

	for i := 0; i < len(even); i++ {
		if even[i] != even2[i] {
			return false
		}
	}

	return true
}