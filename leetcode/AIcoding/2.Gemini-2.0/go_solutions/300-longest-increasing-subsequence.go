func lengthOfLIS(nums []int) int {
	tails := make([]int, 0)
	for _, num := range nums {
		if len(tails) == 0 || num > tails[len(tails)-1] {
			tails = append(tails, num)
		} else {
			l, r := 0, len(tails)-1
			for l <= r {
				mid := l + (r-l)/2
				if tails[mid] < num {
					l = mid + 1
				} else {
					r = mid - 1
				}
			}
			tails[l] = num
		}
	}
	return len(tails)
}