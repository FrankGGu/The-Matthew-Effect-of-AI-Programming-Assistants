func sumOfFlooredPairs(nums []int) int {
	const mod = 1000000007
	maxNum := 0
	for _, num := range nums {
		if num > maxNum {
			maxNum = num
		}
	}

	count := make([]int, maxNum+1)
	for _, num := range nums {
		count[num]++
	}

	prefixSum := make([]int, maxNum+1)
	for i := 1; i <= maxNum; i++ {
		prefixSum[i] = prefixSum[i-1] + count[i]
	}

	ans := 0
	distinctNums := make(map[int]bool)
	for _, num := range nums {
		if _, ok := distinctNums[num]; !ok {
			distinctNums[num] = true
			for i := 1; i*num <= maxNum; i++ {
				left := i * num
				right := (i + 1) * num - 1
				if right > maxNum {
					right = maxNum
				}
				cnt := prefixSum[right] - prefixSum[left-1]
				ans = (ans + cnt*count[num]%mod) % mod
			}
		}
	}
	return ans
}