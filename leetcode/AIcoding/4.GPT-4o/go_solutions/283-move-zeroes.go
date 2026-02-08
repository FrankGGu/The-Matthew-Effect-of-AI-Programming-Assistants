func moveZeroes(nums []int) {
    count := 0
    for i := 0; i < len(nums); i++ {
        if nums[i] != 0 {
            nums[count] = nums[i]
            count++
        }
    }
    for count < len(nums) {
        nums[count] = 0
        count++
    }
}