package main

func minOperations(boxes string) []int {
	n := len(boxes)
	answer := make([]int, n)

	for i := 0; i < n; i++ {
		currentOperations := 0
		for j := 0; j < n; j++ {
			if boxes[j] == '1' {
				diff := i - j
				if diff < 0 {
					diff = -diff
				}
				currentOperations += diff
			}
		}
		answer[i] = currentOperations
	}

	return answer
}