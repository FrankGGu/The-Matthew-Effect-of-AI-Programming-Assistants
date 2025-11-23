import "sort"

func repairCars(ranks []int, cars int) int64 {
	sort.Ints(ranks)
	l, r := 0, int(1e14)
	ans := int64(r)

	check := func(t int64) bool {
		cnt := 0
		for _, rank := range ranks {
			cnt += int((float64(t) / float64(rank)) * (1 / float64(rank)))
		}
		return cnt >= cars
	}

	for l <= r {
		mid := l + (r-l)/2
		if check(int64(mid)) {
			ans = int64(mid)
			r = mid - 1
		} else {
			l = mid + 1
		}
	}

	return ans
}