func countDaysTogether(arriveA string, leaveA string, arriveB string, leaveB string) int {
	days := []int{0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
	prefixSum := make([]int, 13)
	for i := 1; i <= 12; i++ {
		prefixSum[i] = prefixSum[i-1] + days[i]
	}

	arriveADay := prefixSum[int(arriveA[0]-'0')*10+int(arriveA[1]-'0')-1] + int(arriveA[3]-'0')*10 + int(arriveA[4]-'0')
	leaveADay := prefixSum[int(leaveA[0]-'0')*10+int(leaveA[1]-'0')-1] + int(leaveA[3]-'0')*10 + int(leaveA[4]-'0')
	arriveBDay := prefixSum[int(arriveB[0]-'0')*10+int(arriveB[1]-'0')-1] + int(arriveB[3]-'0')*10 + int(arriveB[4]-'0')
	leaveBDay := prefixSum[int(leaveB[0]-'0')*10+int(leaveB[1]-'0')-1] + int(leaveB[3]-'0')*10 + int(leaveB[4]-'0')

	start := max(arriveADay, arriveBDay)
	end := min(leaveADay, leaveBDay)

	if start > end {
		return 0
	}
	return end - start + 1
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}