import "fmt"

func maximumSubarraySum(nums []int, k int) int64 {
    var maxSum int64 = 0
    var currentSum int64 = 0
    counts := make(map[int]int)
    distinctCount := 0
    left := 0