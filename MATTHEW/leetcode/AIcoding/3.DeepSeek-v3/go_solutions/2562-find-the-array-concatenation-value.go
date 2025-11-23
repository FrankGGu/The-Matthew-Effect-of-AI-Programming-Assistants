func findTheArrayConcVal(nums []int) int64 {
    var res int64
    left, right := 0, len(nums)-1
    for left <= right {
        if left == right {
            res += int64(nums[left])
        } else {
            concat := fmt.Sprintf("%d%d", nums[left], nums[right])
            num, _ := strconv.ParseInt(concat, 10, 64)
            res += num
        }
        left++
        right--
    }
    return res
}