package main

func maxChunksToSorted(arr []int) int {
	chunks := 0
	maxVal := 0
	for i := 0; i < len(arr); i++ {
		if arr[i] > maxVal {
			maxVal = arr[i]
		}
		if maxVal == i {
			chunks++
		}
	}
	return chunks
}