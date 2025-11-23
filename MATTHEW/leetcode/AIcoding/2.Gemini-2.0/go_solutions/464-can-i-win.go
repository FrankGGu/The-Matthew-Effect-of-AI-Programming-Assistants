func canIWin(maxChoosableInteger int, desiredTotal int) bool {
	if desiredTotal <= 0 {
		return true
	}
	if (maxChoosableInteger+1)*maxChoosableInteger/2 < desiredTotal {
		return false
	}
	memo := make(map[int]bool)
	nums := make([]bool, maxChoosableInteger+1)
	for i := 1; i <= maxChoosableInteger; i++ {
		nums[i] = true
	}
	var dfs func(int, []bool) bool
	dfs = func(currTotal int, nums []bool) bool {
		hash := 0
		for i := 1; i < len(nums); i++ {
			if nums[i] {
				hash |= (1 << i)
			}
		}
		if val, ok := memo[hash]; ok {
			return val
		}
		for i := 1; i < len(nums); i++ {
			if nums[i] {
				nums[i] = false
				if currTotal+i >= desiredTotal || !dfs(currTotal+i, nums) {
					nums[i] = true
					memo[hash] = true
					return true
				}
				nums[i] = true
			}
		}
		memo[hash] = false
		return false
	}
	return dfs(0, nums)
}