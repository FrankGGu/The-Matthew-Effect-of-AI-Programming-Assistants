func countFairPairs(nums []int, target int) int {
    sort.Ints(nums)
    l, r := 0, len(nums)-1
    count := 0

    for l < r {
        sum := nums[l] + nums[r]
        if sum < target {
            count += r - l
            l++
        } else {
            r--
        }
    }

    return count
}