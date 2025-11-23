func maximumTripletValue(nums []int) int64 {
    n := len(nums)
    if n < 3 {
        return 0
    }
    maxVal := int64(0)
    for i := 0; i < n; i++ {
        for j := i+1; j < n; j++ {
            for k := j+1; k < n; k++ {
                val := int64(nums[i] - nums[j]) * int64(nums[k])
                if val > maxVal {
                    maxVal = val
                }
            }
        }
    }
    if maxVal < 0 {
        return 0
    }
    return maxVal
}