package main

func findNumberOfSubsequencesWithEqualGCD(nums []int, k int) int {
	maxVal := 0
	for _, num := range nums {
		if num > maxVal {
			maxVal = num
		}
	}

	if k > maxVal {
		return 0
	}

	counts := make([]int, maxVal+1)
	for _, num := range nums {
		counts[num]++
	}

	MOD := 1_000_000_007

	pow2 := make([]int, len(nums)+1)
	pow2[0] = 1
	for i := 1; i <= len(nums); i++ {
		pow2[i] = (pow2[i-1] * 2) % MOD
	}

	f := make([]int, maxVal+1)
	ans := make([]int, maxVal+1)

	for g := maxVal; g >= 1; g-- {
		totalCountOfMultiples := 0
		for m := g; m <= maxVal; m += g {
			totalCountOfMultiples += counts[m]
		}

		if totalCountOfMultiples > 0 {
			f[g] = (pow2[totalCountOfMultiples] - 1 + MOD) % MOD
		} else {
			f[g] = 0
		}

		currentAns := f[g]
		for m := 2 * g; m <= maxVal; m += g {
			currentAns = (currentAns - ans[m] + MOD) % MOD
		}
		ans[g] = currentAns
	}

	return ans[k]
}