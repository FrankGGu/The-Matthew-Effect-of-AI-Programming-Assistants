func getNext(n int) int {
	sumOfSquares := 0
	for n > 0 {
		digit := n % 10
		sumOfSquares += digit * digit
		n /= 10
	}
	return sumOfSquares
}

func isHappy(n int) bool {
	slow := n
	fast := getNext(n)
	for fast != 1 && slow != fast {
		slow = getNext(slow)
		fast = getNext(getNext(fast))
	}
	return fast == 1
}