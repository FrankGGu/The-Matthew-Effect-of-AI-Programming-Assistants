func differenceOfDistinctValues(grid [][]int) [][]int {
	m, n := len(grid), len(grid[0])
	ans := make([][]int, m)
	for i := range ans {
		ans[i] = make([]int, n)
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			topLeft := make(map[int]bool)
			bottomRight := make(map[int]bool)

			for x := 0; x < i; x++ {
				for y := 0; y < j; y++ {
					topLeft[grid[x][y]] = true
				}
			}

			for x := i + 1; x < m; x++ {
				for y := j + 1; y < n; y++ {
					bottomRight[grid[x][y]] = true
				}
			}

			ans[i][j] = len(topLeft)
		}
	}

	return ans
}

func maxFrequencyDifference(nums []int) int {
	freq := make(map[int]int)
	for _, num := range nums {
		freq[num]++
	}

	evenFreq := 0
	oddFreq := 0

	for num, count := range freq {
		if num%2 == 0 {
			evenFreq = max(evenFreq, count)
		} else {
			oddFreq = max(oddFreq, count)
		}
	}

	return evenFreq - oddFreq
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}