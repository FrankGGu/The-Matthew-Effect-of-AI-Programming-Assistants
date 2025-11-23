func getConcatenation(nums []int) []int {
    result := make([]int, len(nums)*2)
    copy(result, nums)
    copy(result[len(nums):], nums)
    return result
}