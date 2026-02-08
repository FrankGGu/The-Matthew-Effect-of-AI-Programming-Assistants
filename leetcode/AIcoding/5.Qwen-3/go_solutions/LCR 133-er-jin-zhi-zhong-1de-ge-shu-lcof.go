package main

func hammingNumber(n int) int {
	count := 0
	for n > 0 {
		count += n & 1
		n >>= 1
	}
	return count
}

func hammingWeight(num uint32) int {
	return hammingNumber(int(num))
}