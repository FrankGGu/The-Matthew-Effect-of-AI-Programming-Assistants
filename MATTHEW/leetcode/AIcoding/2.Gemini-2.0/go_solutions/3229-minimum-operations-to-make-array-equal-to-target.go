func minOperations(nums []int, target int) int {
	sum := 0
	for _, num := range nums {
		sum += num
	}

	if sum < target {
		return -1
	}

	counts := make(map[int]int)
	for _, num := range nums {
		counts[num]++
	}

	ans := 0
	cur := target
	for i := 0; i <= 30; i++ {
		if cur%2 == 1 {
			if counts[1<<i] > 0 {
				counts[1<<i]--
			} else {
				j := i + 1
				for j <= 30 && counts[1<<j] == 0 {
					j++
				}
				if j > 30 {
					return -1
				}
				counts[1<<j]--
				for k := j - 1; k >= i; k-- {
					counts[1<<k]++
					ans++
				}
			}
		}
		if counts[1<<i] > 0 {
			counts[1<<(i+1)] += counts[1<<i] / 2
		}
		cur /= 2
	}
	return ans
}