import "math"

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func findTwoNonOverlappingSubarrays(arr []int, target int) int {
	n := len(arr)
	prefixSum := make(map[int]