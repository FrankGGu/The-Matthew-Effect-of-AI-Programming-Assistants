package main

func findPermutation(s string) []int {
	n := len(s)
	result := make([]int, n+1)
	for i := 0; i <= n; i++ {
		result[i] = i + 1
	}
	i := 0
	for i < n {
		if s[i] == 'I' {
			i++
			continue
		}
		j := i
		for j < n && s[j] == 'D' {
			j++
		}
		reverse(result, i, j)
		i = j
	}
	return result
}

func reverse(arr []int, start, end int) {
	for start < end {
		arr[start], arr[end] = arr[end], arr[start]
		start++
		end--
	}
}