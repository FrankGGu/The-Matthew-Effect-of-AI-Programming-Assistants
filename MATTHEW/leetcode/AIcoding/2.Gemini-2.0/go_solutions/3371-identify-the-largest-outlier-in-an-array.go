func findLargestOutlier(nums []int) int {
	n := len(nums)
	if n < 3 {
		return -1
	}

	a := make([]int, n)
	copy(a, nums)

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			if a[i] > a[j] {
				a[i], a[j] = a[j], a[i]
			}
		}
	}

	q1 := a[n/4]
	q3 := a[3*n/4]
	iqr := q3 - q1

	lowerBound := q1 - 1.5*float64(iqr)
	upperBound := q3 + 1.5*float64(iqr)

	largestOutlier := -1

	for _, num := range nums {
		if float64(num) < lowerBound || float64(num) > upperBound {
			if num > largestOutlier {
				largestOutlier = num
			}
		}
	}

	return largestOutlier
}