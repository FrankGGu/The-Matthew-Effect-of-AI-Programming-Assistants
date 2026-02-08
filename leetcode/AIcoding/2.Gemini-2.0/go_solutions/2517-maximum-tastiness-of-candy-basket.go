import (
	"sort"
)

func maximumTastiness(price []int, k int) int {
	sort.Ints(price)
	n := len(price)
	low := 0
	high := price[n-1] - price[0]

	for low < high {
		mid := (low + high + 1) / 2
		count := 1
		prev := price[0]

		for i := 1; i < n; i++ {
			if price[i]-prev >= mid {
				count++
				prev = price[i]
			}
		}

		if count >= k {
			low = mid
		} else {
			high = mid - 1
		}
	}

	return low
}