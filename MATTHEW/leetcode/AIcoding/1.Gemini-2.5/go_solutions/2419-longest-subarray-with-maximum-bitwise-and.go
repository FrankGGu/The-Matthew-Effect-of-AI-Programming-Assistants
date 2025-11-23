func longestSubarray(nums []int) int {
    maxVal := 0
    for _, num := range nums {
        if num > maxVal {
            maxVal = num
        }
    }

    maxLength := 0
    currentLength := 0
    for _, num := range nums {
        if num ==