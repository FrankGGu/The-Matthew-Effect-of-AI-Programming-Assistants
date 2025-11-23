import (
	"strconv"
)

func countSymmetricIntegers(low int, high int) int {
	count := 0
	for i := low; i <= high; i++ {
		s := strconv.Itoa(i)
		n := len(s)

		if n%2 == 0 {
			sum1 := 0
			sum2 := 0

			for j := 0; j < n/2; j++ {
				sum1 += int(s[j] - '0')
			}

			for j := n / 2; j < n; j++ {
				sum2 += int(s[j] - '0')
			}

			if sum1 == sum2 {
				count++
			}
		}
	}
	return count
}