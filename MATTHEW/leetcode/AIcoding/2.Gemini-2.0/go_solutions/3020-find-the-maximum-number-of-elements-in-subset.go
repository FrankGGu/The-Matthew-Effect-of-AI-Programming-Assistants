import "sort"

func maximumLength(nums []int) int {
	counts := make(map[int]int)
	for _, num := range nums {
		counts[num]++
	}

	sort.Ints(nums)
	uniqueNums := []int{}
	seen := make(map[int]bool)
	for _, num := range nums {
		if !seen[num] {
			uniqueNums = append(uniqueNums, num)
			seen[num] = true
		}
	}

	ans := 0
	for _, start := range uniqueNums {
		currLen := 0
		curr := start
		if counts[curr] >= 1 {
			if curr == 1 {
				if counts[curr] >= 1 {
					currLen += counts[curr]
					if currLen%2 == 0 {
						currLen--
					}
				}

			} else {

				for {
					if counts[curr] >= 1 {
						currLen++
						if currLen > 1 && counts[curr] == 1{
							break
						}

						curr *= curr
						if counts[curr] == 0 {
							break
						}
					} else {
						break
					}
				}
				curr = start
				currLen = 0
				for {
					if counts[curr] >= 1 {
						currLen++
						if currLen > 1 && counts[curr] == 1{
							break
						}

						curr *= curr
						if counts[curr] == 0 {
							break
						}
					} else {
						break
					}
				}
			}

		}
		ans = max(ans, currLen)
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}