func canBeIncreasing(nums []int) bool {
	n := len(nums)
	violations := 0
	violationIdx := -1

	for i := 0; i < n-1; i++ {
		if nums[i] >= nums[i+1] {
			violations++
			violationIdx = i
		}
	}

	if violations == 0 {
		return true
	}

	if violations > 1 {
		return false
	}

	// Only one violation found at violationIdx
	// We need to check if removing nums[violationIdx] or nums[violationIdx+1] fixes the array.

	// Option 1: Remove nums[violationIdx]
	// The array becomes nums[0...violationIdx-1], nums[violationIdx+1...n-1]
	// This is valid if:
	// 1. violationIdx is 0 (removing the first element, the rest is already strictly increasing as per violations == 1)
	// OR
	// 2. nums[violationIdx-1] < nums[violationIdx+1] (the elements surrounding the removed one maintain strict increase)
	canRemoveCurrent := (violationIdx == 0) || (nums[violationIdx-1] < nums[violationIdx+1])

	// Option 2: Remove nums[violationIdx+1]
	// The array becomes nums[0...violationIdx], nums[violationIdx+2...n-1]
	// This is valid if:
	// 1. violationIdx+1 is n-1 (removing the last element, the rest is already strictly increasing as per violations == 1)
	// OR
	// 2. nums[violationIdx] < nums[violationIdx+2] (the elements surrounding the removed one maintain strict increase)
	canRemoveNext := (violationIdx+1 == n-1) || (nums[violationIdx] < nums[violationIdx+2])

	return canRemoveCurrent || canRemoveNext
}