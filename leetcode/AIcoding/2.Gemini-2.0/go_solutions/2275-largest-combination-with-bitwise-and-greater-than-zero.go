func largestCombination(candidates []int) int {
	ans := 0
	for i := 0; i < 32; i++ {
		cnt := 0
		for _, num := range candidates {
			if (num>>i)&1 == 1 {
				cnt++
			}
		}
		if cnt > ans {
			ans = cnt
		}
	}
	return ans
}