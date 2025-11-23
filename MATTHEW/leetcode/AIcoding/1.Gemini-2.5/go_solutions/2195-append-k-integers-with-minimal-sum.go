import "sort"

func minimalKSum(nums []int, k int64) int64 {
    // Sort nums to easily process numbers in increasing order and handle duplicates.
    sort.Ints(nums)

    var totalSum int64 = 0
    var currentK int64 = k // currentK tracks the upper bound