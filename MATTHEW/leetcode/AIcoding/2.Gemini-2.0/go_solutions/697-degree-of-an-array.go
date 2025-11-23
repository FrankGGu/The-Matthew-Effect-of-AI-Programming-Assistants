func findShortestSubArray(nums []int) int {
	first := make(map[int]int)
	last := make(map[int]int)
	count := make(map[int]int)

	for i, num := range nums {
		if _, ok := first[num]; !ok {
			first[num] = i
		}
		last[num] = i
		count[num]++
	}

	degree := 0
	for _, c := range count {
		if c > degree {
			degree = c
		}
	}

	ans := len(nums)
	for num, c := range count {
		if c == degree {
			length := last[num] - first[num] + 1
			if length < ans {
				ans = length
			}
		}
	}

	return ans
}