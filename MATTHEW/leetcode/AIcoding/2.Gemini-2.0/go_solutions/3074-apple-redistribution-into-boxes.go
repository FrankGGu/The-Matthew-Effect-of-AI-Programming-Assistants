func minOperations(n int, capacity []int, boxes [][]int) int {
	ans := 0
	for _, box := range boxes {
		sum := 0
		for _, apple := range box {
			sum += apple
		}
		if sum > capacity[0] {
			ans += sum - capacity[0]
		}
	}
	return ans
}