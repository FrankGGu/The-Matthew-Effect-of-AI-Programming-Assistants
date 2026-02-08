func triangleNumber(nums []int) int {
    sort.Ints(nums)
    count := 0
    n := len(nums)

    for i := 0; i < n-2; i++ {
        k := i + 2
        for j := i + 1; j < n-1; j++ {
            for k < n && nums[i]+nums[j] > nums[k] {
                k++
            }
            count += k - j - 1
        }
    }

    return count
}