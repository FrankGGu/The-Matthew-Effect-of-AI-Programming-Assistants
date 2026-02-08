package main

func partitionLabels(s string) []int {
	last := make([]int, 26)
	for i, c := range s {
		last[c-'a'] = i
	}
	result := []int{}
	start, end := 0, 0
	for i, c := range s {
		end = max(end, last[c-'a'])
		if i == end {
			result = append(result, end-start+1)
			start = i + 1
		}
	}
	return result
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}