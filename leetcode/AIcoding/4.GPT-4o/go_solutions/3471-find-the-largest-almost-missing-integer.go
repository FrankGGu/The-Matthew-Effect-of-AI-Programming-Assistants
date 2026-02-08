func findLargestMissing(nums []int) int {
    n := len(nums)
    present := make([]bool, n+2)

    for _, num := range nums {
        if num > 0 && num <= n {
            present[num] = true
        }
    }

    for i := n; i >= 1; i-- {
        if !present[i] {
            return i
        }
    }

    return n + 1
}