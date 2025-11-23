func validSubarraySize(nums []int, threshold int) int {
    n := len(nums)
    for size := 1; size <= n; size++ {
        for i := 0; i <= n-size; i++ {
            valid := true
            count := 0
            for j := i; j < i+size; j++ {
                if nums[j] > threshold/size {
                    count++
                } else {
                    valid = false
                    break
                }
            }
            if valid {
                return size
            }
        }
    }
    return -1
}