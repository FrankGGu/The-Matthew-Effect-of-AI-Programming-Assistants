package main

func replaceElements(arr []int) []int {
	maxRight := -1
	for i := len(arr) - 1; i >= 0; i-- {
		currentElement := arr[i]
		arr[i] = maxRight
		if currentElement > maxRight {
			maxRight = currentElement
		}
	}
	return arr
}