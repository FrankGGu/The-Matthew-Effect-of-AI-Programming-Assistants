func pivotArray(nums []int, pivot int) []int {
    n := len(nums)
    ans := make([]int, n)

    k := 0
    for i := 0; i < n; i++ {
        if nums[i] < pivot {
            ans[k] = nums[i]
            k++
        }
    }

    for i := 0; i < n; i++ {
        if nums[i] == pivot {
            ans[k] = nums[i]
            k++
        }
    }

    for i := 0; i < n; i++ {
        if nums[i] > pivot {
            ans[k] = nums[i]
            k++
        }
    }

    return ans
}