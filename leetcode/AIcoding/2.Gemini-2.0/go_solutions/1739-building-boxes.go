import "math"

func minimumBoxes(n int) int {
	k := 0
	for n > 0 {
		k++
		n -= k * (k + 1) / 2
	}
	n += k * (k + 1) / 2
	k--

	res := k * (k + 1) / 2

	l := 1
	r := k + 2

	for l < r {
		mid := l + (r-l)/2
		if mid*(mid+1)/2 >= n-res {
			r = mid
		} else {
			l = mid + 1
		}
	}

	return res + l
}

func main() {}