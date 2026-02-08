package main

func numSubmatrixSumTarget(matrix [][]int, target int) int {
	rows := len(matrix)
	cols := len(matrix[0])
	count := 0

	for c1 := 0; c1 < cols; c1++ {
		rowSums := make([]int, rows)
		for c2 := c1; c2 < cols; c2++ {
			for r := 0; r < rows; r++ {
				rowSums[r] += matrix[r][c2]
			}

			// Now rowSums is a 1D array, find subarrays that sum to target
			freq := make(map[int]int)
			freq[0] = 1
			currentSum := 0
			for _, val := range rowSums {
				currentSum += val
				if c, ok := freq[currentSum-target]; ok {
					count += c
				}
				freq[currentSum]++
			}
		}
	}

	return count
}