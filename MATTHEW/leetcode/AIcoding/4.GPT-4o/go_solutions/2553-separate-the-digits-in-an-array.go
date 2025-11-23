func separateDigits(nums []int) []int {
    result := []int{}
    for _, num := range nums {
        digits := []int{}
        for num > 0 {
            digits = append([]int{num % 10}, digits...)
            num /= 10
        }
        result = append(result, digits...)
    }
    return result
}