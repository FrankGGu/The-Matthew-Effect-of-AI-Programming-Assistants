func removeDuplicates(nums []int) int {
    if len(nums) < 3 {
        return len(nums)
    }

    count := 1
    index := 1

    for i := 2; i < len(nums); i++ {
        if nums[i] == nums[i-1] {
            count++
        } else {
            count = 1
        }

        if count <= 2 {
            nums[index] = nums[i]
            index++
        }
    }

    return index
}