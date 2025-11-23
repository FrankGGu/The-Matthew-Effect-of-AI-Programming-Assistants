func sortEvenOdd(nums []int) []int {
	n := len(nums)
	if n <= 1 {
		return nums
	}

	evenElements := []int{}
	oddElements := []int{}

	for i := 0; i < n; i++ {
		if i%2 == 0 {
			evenElements = append(evenElements, nums[i])
		} else {
			oddElements = append(oddElements, nums[i])
		}
	}

	sort.Ints(evenElements)

	sort.Ints(oddElements)
	for i, j := 0, len(oddElements)-1; i < j; i, j = i+1, j-1 {
		oddElements[i], oddElements[j] = oddElements[j], oddElements[i]
	}

	evenIdx := 0
	oddIdx := 0
	for i := 0; i < n; i++ {
		if i%2 == 0 {
			nums[i] = evenElements[evenIdx]
			evenIdx++
		} else {
			nums[i] = oddElements[oddIdx]
			oddIdx++
		}
	}

	return nums
}