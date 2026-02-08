import (
	"math"
)

func minSpeedOnTime(dist []int, hour float64) int {
	n := len(dist)
	if float64(n-1) >= hour {
		return -1
	}

	l, r := 1, 10000000
	ans := -1

	for l <= r {
		mid := l + (r-l)/2
		time := 0.0
		for i := 0; i < n-1; i++ {
			time += math.Ceil(float64(dist[i]) / float64(mid))
		}
		time += float64(dist[n-1]) / float64(mid)

		if time <= hour {
			ans = mid
			r = mid - 1
		} else {
			l = mid + 1
		}
	}

	return ans
}