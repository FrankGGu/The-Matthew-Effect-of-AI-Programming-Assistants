func findErrorNums(nums []int) []int {
    n := len(nums)
    seen := make(map[int]bool)
    sum := 0
    expectedSum := n * (n + 1) / 2
    duplicate := -1

    for _, num := range nums {
        sum += num
        if seen[num] {
            duplicate = num
        }
        seen[num] = true
    }

    missing := expectedSum - (sum - duplicate)
    return []int{duplicate, missing}
}