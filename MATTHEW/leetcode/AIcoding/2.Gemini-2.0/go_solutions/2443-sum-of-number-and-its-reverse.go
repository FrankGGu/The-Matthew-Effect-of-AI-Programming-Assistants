func sumOfNumberAndReverse(num int) int {
	count := 0
	for i := 0; i <= num; i++ {
		if i+reverse(i) == num {
			count++
		}
	}
	return count
}

func reverse(x int) int {
	rev := 0
	for x > 0 {
		pop := x % 10
		x /= 10
		rev = rev*10 + pop
	}
	return rev
}