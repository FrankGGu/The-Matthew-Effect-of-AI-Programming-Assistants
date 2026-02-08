func maximumTripletValue(nums []int) int64 {
    n := len(nums)
    if n < 3 {
        return 0
    }

    var maxVal int64 = 0

    for i := 0; i < n-2; i++ {
        for j := i + 1; j < n-1; j++ {
            for k := j + 1; k < n; k++ {
                currentVal := int64(nums[i]-nums[j]) * int64(nums[k])
                if currentVal > maxVal {
                    maxVal = currentVal
                }
            }
        }
    }
    return maxVal
}