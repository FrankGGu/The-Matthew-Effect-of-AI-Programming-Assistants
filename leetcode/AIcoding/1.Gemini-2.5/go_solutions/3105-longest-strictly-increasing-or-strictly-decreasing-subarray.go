import "math"

func longestSubarray(nums []int) int {
    n := len(nums)
    if n <= 1 {
        return n
    }

    maxLen := 1
    incLen := 1 // current length of strictly increasing subarray ending at current position
    decLen := 1 // current