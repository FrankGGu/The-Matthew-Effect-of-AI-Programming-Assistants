package main

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func subarrayGCD(nums []int, k int) int {
	count := 0
	n := len(nums)

	for i := 0; i < n; i++ {
		currentGCD := 0
		for j := i; j < n; j++ {
			if nums[j]%k != 0 {
				break
			}

			if currentGCD == 0 {
				currentGCD = nums[j]
			} else {
				currentGCD = gcd(currentGCD, nums[j])
			}

			if currentGCD == k {
				count++
			} else if currentGCD < k {
				break
			}
		}
	}
	return count
}