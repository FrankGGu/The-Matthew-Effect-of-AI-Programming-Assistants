package main

func threeEqualParts(arr []int) []int {
	n := len(arr)
	ones := make([]int, 0)
	for i, v := range arr {
		if v == 1 {
			ones = append(ones, i)
		}
	}
	if len(ones) == 0 {
		return []int{0, 1, 2}
	}
	if len(ones)%3 != 0 {
		return []int{-1, -1, -1}
	}
	k := len(ones) / 3
	first := ones[0]
	second := ones[k]
	third := ones[2*k]
	for i := 0; i < n-third; i++ {
		if arr[first+i] != arr[second+i] || arr[first+i] != arr[third+i] {
			return []int{-1, -1, -1}
		}
	}
	return []int{first + k, second + k, third + k}
}