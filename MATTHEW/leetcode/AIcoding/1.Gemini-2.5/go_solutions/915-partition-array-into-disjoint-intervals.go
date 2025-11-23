import "math"

func partitionDisjoint(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0 // Or handle error, though constraints say n >= 2
    }

    // current_max_left tracks the maximum element in the current candidate left partition.
    // Initially