import "fmt"

func minimumIndex(nums []int) int {
    n := len(nums)

    // Step 1: Find the dominant element of the entire array.
    // If no dominant element exists for the whole array, then no such split is possible.
    counts := make(map[int]int)