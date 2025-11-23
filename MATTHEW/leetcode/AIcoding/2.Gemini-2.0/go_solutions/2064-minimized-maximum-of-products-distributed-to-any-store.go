import "sort"

func minimizedMaximum(n int, quantities []int) int {
	sort.Ints(quantities)
	l, r := 1, quantities[len(quantities)-1]
	ans := r
	for l <= r {
		mid := l + (r-l)/2
		count := 0
		for _, q := range quantities {
			count += (q + mid - 1) / mid
		}
		if count <= n {
			ans = mid
			r = mid - 1
		} else {
			l = mid + 1
		}
	}
	return ans
}