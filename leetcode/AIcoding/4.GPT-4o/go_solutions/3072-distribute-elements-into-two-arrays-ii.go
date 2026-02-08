func distributeElements(nums []int) [][]int {
    n := len(nums)
    ans := make([][]int, 2)
    sort.Ints(nums)

    for i := 0; i < n; i++ {
        ans[i%2] = append(ans[i%2], nums[i])
    }

    return ans
}