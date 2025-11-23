func separateDigits(nums []int) []int {
    var result []int

    for _, num := range nums {
        var tempDigits []int
        for num > 0 {
            digit := num % 10
            tempDigits = append(tempDigits, digit)
            num /= 10
        }

        for i := len(tempDigits) - 1; i >= 0; i-- {
            result = append(result, tempDigits[i])
        }
    }

    return result
}