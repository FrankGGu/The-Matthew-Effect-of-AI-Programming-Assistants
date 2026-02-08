func longestOnes(nums []int, k int) int {
    left := 0
    zeroCount := 0
    maxLength := 0

    for right := 0; right < len(nums); right++ {
        if nums[right] == 0 {
            zeroCount++
        }

        for zero