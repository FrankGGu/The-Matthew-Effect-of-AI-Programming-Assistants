func countTarget(scores []int, target int) int {
	firstIdx := sort.SearchInts(scores, target)
	endIdx := sort.SearchInts(scores, target+1)
	return endIdx - firstIdx
}