func maximumOr(nums []int, k int) int {
	n := len(nums)
	prefix := make([]int, n)
	suffix := make([]int, n)

	prefix[0] = nums[0]
	for i := 1; i < n; i++ {
		prefix[i] = prefix[i-1] | nums[i]
	}

	suffix[n-1] = nums[n-1]
	for i := n-2; i >= 0; i-- {
		suffix[i] = suffix[i+1] | nums[i]
	}

	ans := 0
	for i := 0; i < n; i++ {
		curr := nums[i] << int(logBase2(float64(k))+1e-9)
		temp := 0
		if i > 0 {
			temp |= prefix[i-1]
		}
		if i < n-1 {
			temp |= suffix[i+1]
		}
		ans = max(ans, curr | temp)
	}

	return ans
}

func logBase2(n float64) float64 {
	return log(n) / log(2)
}

func log(n float64) float64 {
    var result float64
    var a float64 = n
    var count int = 0
    if a >= 1 {
        for a >= 2 {
            a = a / 2
            count++
        }
        result = float64(count)
    } else {
        for a < 1 {
            a = a * 2
            count++
        }
        result = float64(-count)
    }
    return result
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}