package main

func canBeSorted(nums []int) bool {
    n := len(nums)
    sorted := make([]int, n)
    copy(sorted, nums)
    sort.Ints(sorted)

    for i := 0; i < n; i++ {
        if nums[i] != sorted[i] {
            j := i + 1
            for j < n && nums[j] == nums[i] {
                j++
            }
            if j < n && nums[j] != sorted[j] {
                return false
            }
        }
    }

    return true
}