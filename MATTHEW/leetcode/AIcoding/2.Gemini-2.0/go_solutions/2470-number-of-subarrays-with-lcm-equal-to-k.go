func subarrayLCM(nums []int, k int) int {
	count := 0
	for i := 0; i < len(nums); i++ {
		lcm := 1
		for j := i; j < len(nums); j++ {
			lcm = findLCM(lcm, nums[j])
			if lcm == k {
				count++
			} else if lcm > k {
				break
			}
		}
	}
	return count
}

func findLCM(a, b int) int {
	return a * b / findGCD(a, b)
}

func findGCD(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}