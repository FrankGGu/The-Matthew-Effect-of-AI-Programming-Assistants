func smallestValue(n int) int {
	for {
		sum := 0
		temp := n
		for i := 2; i*i <= temp; i++ {
			for temp%i == 0 {
				sum += i
				temp /= i
			}
		}
		if temp > 1 {
			sum += temp
		}
		if sum == n {
			return n
		}
		n = sum
	}
}