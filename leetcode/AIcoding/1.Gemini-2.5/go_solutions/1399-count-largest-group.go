package main

func countLargestGroup(n int) int {
	digitSumCounts := make(map[int]int)

	for i := 1; i <= n; i++ {
		sum := 0
		num := i
		for num > 0 {
			sum += num % 10
			num /= 10
		}
		digitSumCounts[sum]++
	}

	maxSize := 0
	for _, count := range digitSumCounts {
		if count > maxSize {
			maxSize = count
		}
	}

	numLargestGroups := 0
	for _, count := range digitSumCounts {
		if count == maxSize {
			numLargestGroups++
		}
	}

	return numLargestGroups
}