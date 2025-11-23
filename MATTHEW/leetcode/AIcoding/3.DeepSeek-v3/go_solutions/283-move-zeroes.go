func moveZeroes(nums []int)  {
    lastNonZero := 0
    for i := 0; i < len(nums); i++ {
        if nums[i] != 0 {
            nums[lastNonZero], nums[i] = nums[i], nums[lastNonZero]
            lastNonZero++
        }
    }
}