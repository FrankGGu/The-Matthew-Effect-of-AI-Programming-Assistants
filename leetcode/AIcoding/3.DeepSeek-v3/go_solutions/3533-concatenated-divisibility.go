func concatenatedDivisibility(nums []int, k int) int {
    n := len(nums)
    count := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            concat := nums[i]
            temp := nums[j]
            if temp == 0 {
                concat *= 10
            } else {
                for temp > 0 {
                    concat *= 10
                    temp /= 10
                }
                concat += nums[j]
            }
            if concat%k == 0 {
                count++
            }
        }
    }
    return count
}