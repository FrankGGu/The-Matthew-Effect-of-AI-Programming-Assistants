import "sort"

func maxHappyGroups(batchSize int, groups []int) int {
	counts := make([]int, batchSize)
	for _, g := range groups {
		counts[g%batchSize]++
	}

	ans := counts[0]
	counts[0] = 0

	if batchSize%2 == 0 {
		ans += min(counts[batchSize/2], 1)
		counts[batchSize/2] = 0
	}

	for i := 1; i <= batchSize/2; i++ {
		ans += max(counts[i], counts[batchSize-i])
		diff := abs(counts[i] - counts[batchSize-i])
		counts[i] = 0
		counts[batchSize-i] = 0
		counts[1] += diff
	}

	dp := make(map[string]int)

	var dfs func(arr []int) int
	dfs = func(arr []int) int {
		key := ""
		for _, v := range arr {
			key += string(rune(v)) + ","
		}
		if val, ok := dp[key]; ok {
			return val
		}

		sum := 0
		for i := 0; i < len(arr); i++ {
			sum += i * arr[i]
		}

		if sum == 0 {
			return 0
		}

		res := 0
		for i := 1; i < len(arr); i++ {
			if arr[i] > 0 {
				nextArr := make([]int, len(arr))
				copy(nextArr, arr)
				nextArr[i]--
				res = max(res, (batchSize-i)%batchSize == 0 + dfs(nextArr))
			}
		}

		dp[key] = res
		return res
	}

	arr := make([]int, batchSize)
	for i := 1; i < batchSize; i++ {
		arr[i] = counts[i]
	}

	ans += dfs(arr)
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}

func main() {}