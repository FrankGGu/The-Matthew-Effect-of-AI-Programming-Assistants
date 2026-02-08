func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func countDifferentSubsequenceGCDs(nums []int) int {
	maxNum := 0
	for _, num := range nums {
		if num > maxNum {
			maxNum = num
		}
	}

	present := make([]bool, maxNum+1)
	for _, num := range nums {
		present[num] = true
	}

	count := 0
	for i := 1; i <= maxNum; i++ {
		currentGCD := 0
		for j := i; j <= maxNum; j += i {
			if present[j] {
				if currentGCD == 0 {
					currentGCD = j
				} else {
					currentGCD = gcd(currentGCD, j)
				}
			}
		}
		if currentGCD == i {
			count++
		}
	}

	return count
}