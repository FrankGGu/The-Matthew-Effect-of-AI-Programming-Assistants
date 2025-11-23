package main

func separateDigits(nums []int) []int {
	var result []int
	for _, num := range nums {
		for num > 0 {
			result = append(result, num%10)
			num /= 10
		}
	}
	for i, j := 0, len(result)-1; i < j; i, j = i+1, j-1 {
		result[i], result[j] = result[j], result[i]
	}
	return result
}