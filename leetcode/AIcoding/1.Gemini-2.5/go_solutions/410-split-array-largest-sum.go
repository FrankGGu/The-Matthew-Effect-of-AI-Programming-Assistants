func splitArray(nums []int, k int) int {
    left := 0 // Max element in nums
    right := 0 // Sum of all elements in nums

    for _, num := range nums {
        if num > left {
            left = num
        }
        right += num
    }

    ans := right