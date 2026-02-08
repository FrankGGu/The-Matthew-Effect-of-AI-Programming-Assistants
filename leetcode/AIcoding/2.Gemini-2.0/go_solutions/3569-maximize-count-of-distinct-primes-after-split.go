func distinctPrimeFactors(n int) int {
	count := 0
	for i := 2; i*i <= n; i++ {
		if n%i == 0 {
			count++
			for n%i == 0 {
				n /= i
			}
		}
	}
	if n > 1 {
		count++
	}
	return count
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maximizeGreatness(nums []int) int {
	n := len(nums)
	if n == 1 {
		return 1
	}

	ans := 0

	for i := 1; i < n; i++ {
		ans = max(ans, distinctPrimeFactors(nums[i-1]) + distinctPrimeFactors(nums[i]))
	}

	return ans
}

func maximizeCountOfDistinctPrimesAfterSplit(nums []int) int {
    n := len(nums)

    ans := 0

    prefixPrimes := 0
    for i := 0; i < n; i++ {
        prefixPrimes += distinctPrimeFactors(nums[i])
    }

    suffixPrimes := 0
    for i := n - 1; i >= 0; i-- {
        currentPrefix := 0
        for j := 0; j <= i; j++ {
            currentPrefix += distinctPrimeFactors(nums[j])
        }

        currentSuffix := 0
        for j := i + 1; j < n; j++ {
            currentSuffix += distinctPrimeFactors(nums[j])
        }

        ans = max(ans, max(currentPrefix, currentSuffix))

    }

    return ans
}