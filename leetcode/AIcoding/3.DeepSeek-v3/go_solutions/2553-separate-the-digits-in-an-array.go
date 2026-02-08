func separateDigits(nums []int) []int {
    var result []int
    for _, num := range nums {
        var digits []int
        if num == 0 {
            digits = append(digits, 0)
        } else {
            for num > 0 {
                digits = append(digits, num % 10)
                num /= 10
            }
            for i, j := 0, len(digits)-1; i < j; i, j = i+1, j-1 {
                digits[i], digits[j] = digits[j], digits[i]
            }
        }
        result = append(result, digits...)
    }
    return result
}