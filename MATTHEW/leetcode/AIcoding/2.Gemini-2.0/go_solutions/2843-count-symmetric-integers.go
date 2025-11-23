func countSymmetricIntegers(low int, high int) int {
	count := 0
	for i := low; i <= high; i++ {
		s := strconv.Itoa(i)
		n := len(s)
		if n%2 == 0 {
			sum1 := 0
			sum2 := 0
			for j := 0; j < n/2; j++ {
				digit, _ := strconv.Atoi(string(s[j]))
				sum1 += digit
			}
			for j := n / 2; j < n; j++ {
				digit, _ := strconv.Atoi(string(s[j]))
				sum2 += digit
			}
			if sum1 == sum2 {
				count++
			}
		}
	}
	return count
}

import "strconv"