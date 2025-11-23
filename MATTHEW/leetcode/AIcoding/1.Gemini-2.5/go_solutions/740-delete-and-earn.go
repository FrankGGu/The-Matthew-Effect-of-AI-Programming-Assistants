import "math"

func deleteAndEarn(nums []int) int {
    if len(nums) == 0 {
        return 0
    }

    maxVal := 0
    for _, num := range nums {
        if num > maxVal {
            maxVal = num
        }
    }