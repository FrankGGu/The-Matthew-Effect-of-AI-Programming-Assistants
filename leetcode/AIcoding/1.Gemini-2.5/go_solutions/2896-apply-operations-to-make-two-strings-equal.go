import "math"

func minOperations(s1 string, s2 string, x int) int {
	diffIndices := []int{}
	for i := 0; i < len(s1); i++ {
		if s1[i] != s2[i] {
			diffIndices = append(diffIndices,