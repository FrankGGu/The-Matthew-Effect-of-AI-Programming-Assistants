import "math"

func minimumRounds(bamboos []int) int {
	n := len(bamboos)
	ans := 0
	for i := 0; i < n; i++ {
		if bamboos[i] == 1 {
			return -1
		}
		if bamboos[i] == 2 {
			ans++
		} else if bamboos[i] == 3 {
			ans++
		} else {
			ans += int(math.Ceil(float64(bamboos[i]) / 3.0))
		}
	}
	return ans
}