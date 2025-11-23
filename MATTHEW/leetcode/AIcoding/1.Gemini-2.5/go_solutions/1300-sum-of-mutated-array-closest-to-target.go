import "sort"
import "math"

func findBestValue(arr []int, target int) int {
    // Find the maximum element in arr to set an upper bound for binary search.
    // A safe upper bound would be max(arr) or target, or even 100,000 based on constraints.
    //