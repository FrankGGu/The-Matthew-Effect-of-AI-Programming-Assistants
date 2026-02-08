func subarrayGCD(nums []int, k int) int {
	count := 0
	for i := 0; i < len(nums); i++ {
		gcd := 0
		for j := i; j < len(nums); j++ {
			gcd = findGCD(gcd, nums[j])
			if gcd == k {
				count++
			} else if gcd < k {
				break
			}
		}
	}
	return count
}

func findGCD(a int, b int) int {
	if a == 0 {
		return b
	}
	if b == 0 {
		return a
	}
	for b != 0 {
		a, b = b, a%b
	}
	return a
}