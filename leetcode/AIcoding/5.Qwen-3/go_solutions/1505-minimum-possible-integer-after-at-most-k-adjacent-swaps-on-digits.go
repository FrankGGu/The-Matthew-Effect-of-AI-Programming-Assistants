package main

func minIntegerNumber(num string, k int) string {
    n := len(num)
    nums := []byte(num)
    for i := 0; i < n && k > 0; i++ {
        minPos := i
        for j := i + 1; j < n && j - i <= k; j++ {
            if nums[j] < nums[minPos] {
                minPos = j
            }
        }
        if minPos != i {
            for j := minPos; j > i; j-- {
                nums[j], nums[j-1] = nums[j-1], nums[j]
                k--
            }
        }
    }
    return string(nums)
}