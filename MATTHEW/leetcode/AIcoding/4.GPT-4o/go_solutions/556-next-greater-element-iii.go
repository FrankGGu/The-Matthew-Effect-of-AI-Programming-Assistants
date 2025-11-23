func nextGreaterElement(n int) int {
    nums := []int{}
    for n > 0 {
        nums = append(nums, n%10)
        n /= 10
    }
    for i := 0; i < len(nums)/2; i++ {
        nums[i], nums[len(nums)-1-i] = nums[len(nums)-1-i], nums[i]
    }

    for i := len(nums) - 2; i >= 0; i-- {
        if nums[i] < nums[i+1] {
            for j := len(nums) - 1; j > i; j-- {
                if nums[j] > nums[i] {
                    nums[i], nums[j] = nums[j], nums[i]
                    sort.Ints(nums[i+1:])
                    result := 0
                    for _, num := range nums {
                        result = result*10 + num
                    }
                    if result > math.MaxInt32 {
                        return -1
                    }
                    return result
                }
            }
        }
    }
    return -1
}