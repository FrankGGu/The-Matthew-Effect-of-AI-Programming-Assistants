import "sort"

func maximumLength(nums []int) int {
	count := make(map[int]int)
	for _, num := range nums {
		count[num]++
	}

	uniqueNums := make([]int, 0, len(count))
	for num := range count {
		uniqueNums = append(uniqueNums, num)
	}
	sort.Ints(uniqueNums)

	ans := 0
	for _, start := range uniqueNums {
		length := 0
		curr := start
		for {
			if cnt, ok := count[curr]; ok {
				if cnt >= 2 {
					length += 2
				} else if cnt == 1 {
					length++
					if length > 1 {
						ans = max(ans, length)
					}

					break
				} else {
					break
				}
				if curr == 1 {
					break
				}
				if curr*curr > 1e9 {
					break
				}

				curr *= curr

			} else {
				if length > 1 {
					ans = max(ans, length)
				}
				break
			}
			if count[curr] == 1 && length > 0{
				length++
				ans = max(ans, length)
				break
			}
			if count[curr] < 2 {
				length++
				ans = max(ans, length)
				break
			}

		}
		ans = max(ans, length)
	}

	if _, ok := count[1]; ok{
		ans = max(ans, count[1])
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}