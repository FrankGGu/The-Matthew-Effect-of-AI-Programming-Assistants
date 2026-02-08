func findTheArrayConcVal(nums []int) int64 {
    n := len(nums)
    var result int64 = 0
    for i := 0; i < (n+1)/2; i++ {
        if i != n-1-i {
            result += int64(nums[i]*int(math.Pow(10, float64(len(strconv.Itoa(nums[n-1-i])))))) + int64(nums[n-1-i])
        } else {
            result += int64(nums[i])
        }
    }
    return result
}