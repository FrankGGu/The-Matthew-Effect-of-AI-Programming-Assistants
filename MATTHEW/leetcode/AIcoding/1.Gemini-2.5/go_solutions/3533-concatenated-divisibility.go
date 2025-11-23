package main

func getNumDigits(n int) int {
	if n == 0 {
		return 1
	}
	count := 0
	for n > 0 {
		n /= 10
		count++
	}
	return count
}

func canBeDivisible(nums []int, k int) bool {
	n := len(nums)
	if n == 0 {
		return true
	}

	maxSingleNumDigits := 0
	for _, num := range nums {
		digits := getNumDigits(num)
		if digits > maxSingleNumDigits {
			maxSingleNumDigits = digits
		}
	}

	powersOf10ModK := make([]int, maxSingleNumDigits+1)
	powersOf10ModK[0] = 1 % k
	for i := 1; i <= maxSingleNumDigits; i++ {
		powersOf10ModK[i] = (powersOf10ModK[i-1] * 10) % k
	}

	visited := make([]bool, n)

	var backtrack func(count int, currentMod int) bool
	backtrack = func(count int, currentMod int) bool {
		if count == n {
			return currentMod == 0
		}

		for i := 0; i < n; i++ {
			if !visited[i] {
				visited[i] = true
				num := nums[i]
				digits := getNumDigits(num)

				newMod := (currentMod * powersOf10ModK[digits] % k + num % k) % k

				if backtrack(count+1, newMod) {
					return true
				}
				visited[i] = false
			}
		}
		return false
	}

	return backtrack(0, 0)
}