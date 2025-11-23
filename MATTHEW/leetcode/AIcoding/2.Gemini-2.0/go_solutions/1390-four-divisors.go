import "math"

func sumFourDivisors(nums []int) int {
	sum := 0
	for _, num := range nums {
		divisors := findDivisors(num)
		if len(divisors) == 4 {
			for _, d := range divisors {
				sum += d
			}
		}
	}
	return sum
}

func findDivisors(n int) []int {
	divisors := []int{}
	for i := 1; i <= int(math.Sqrt(float64(n))); i++ {
		if n%i == 0 {
			if i*i == n {
				divisors = append(divisors, i)
			} else {
				divisors = append(divisors, i, n/i)
			}
		}
	}
	if len(divisors) != 4 {
		return []int{}
	}

	return divisors
}