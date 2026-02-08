import "sort"

func maxDistance(position []int, m int) int {
	sort.Ints(position)
	n := len(position)

	check := func(dist int) bool {
		count := 1
		lastPos := position[0]
		for i := 1; i < n; i++ {
			if position[i]-lastPos >= dist {
				count++
				lastPos = position[i]
			}
		}
		return count >= m
	}

	left, right := 1, position[n-1]-position[0]
	ans := 0
	for left <= right {
		mid := left + (right-left)/2
		if check(mid) {
			ans = mid
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	return ans
}