package main

func maximumSwap(num int) int {
	if num < 10 {
		return num
	}
	numStr := []byte(strconv.Itoa(num))
	maxIndex := len(numStr) - 1
	for i := len(numStr) - 1; i >= 0; i-- {
		if numStr[i] > numStr[maxIndex] {
			maxIndex = i
		}
	}
	for i := 0; i < len(numStr); i++ {
		if numStr[i] < numStr[maxIndex] {
			numStr[i], numStr[maxIndex] = numStr[maxIndex], numStr[i]
			break
		}
	}
	result, _ := strconv.Atoi(string(numStr))
	return result
}