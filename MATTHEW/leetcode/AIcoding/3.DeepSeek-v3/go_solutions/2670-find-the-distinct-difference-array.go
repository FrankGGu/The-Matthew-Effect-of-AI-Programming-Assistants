func distinctDifferenceArray(nums []int) []int {
    n := len(nums)
    prefix := make([]int, n)
    suffix := make([]int, n)
    prefixSet := make(map[int]bool)
    suffixSet := make(map[int]bool)

    for i := 0; i < n; i++ {
        prefixSet[nums[i]] = true
        prefix[i] = len(prefixSet)
    }

    for i := n - 1; i >= 0; i-- {
        suffixSet[nums[i]] = true
        suffix[i] = len(suffixSet)
    }

    res := make([]int, n)
    for i := 0; i < n; i++ {
        var suffixCount int
        if i + 1 < n {
            suffixCount = suffix[i+1]
        } else {
            suffixCount = 0
        }
        res[i] = prefix[i] - suffixCount
    }

    return res
}