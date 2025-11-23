func maxProfit(inventory []int, orders int) int {
	l, r := 1, 1000000000
	for l < r {
		mid := (l + r) / 2
		count := 0
		for _, v := range inventory {
			if v > mid {
				count += v - mid
			}
		}
		if count >= orders {
			l = mid + 1
		} else {
			r = mid
		}
	}
	ans := 0
	count := 0
	for _, v := range inventory {
		if v > l-1 {
			n := v - (l - 1)
			ans = (ans + (v + l) * n / 2) % 1000000007
			count += n
		}
	}
	ans = (ans + (orders - count) * (l - 1)) % 1000000007
	return ans
}