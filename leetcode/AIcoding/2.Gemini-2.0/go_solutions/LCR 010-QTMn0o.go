func subarraySum(nums []int, k int) int {
	count := 0
	sumMap := make(map[int]int)
	sumMap[0] = 1
	sum := 0
	for _, num := range nums {
		sum += num
		if val, ok := sumMap[sum-k]; ok {
			count += val
		}
		sumMap[sum]++
	}
	return count
}