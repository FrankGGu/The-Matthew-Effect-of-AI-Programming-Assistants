func kLengthApart(nums []int, k int) bool {
    prev := -k - 1
    for i, num := range nums {
        if num == 1 {
            if i - prev - 1 < k {
                return false
            }
            prev = i
        }
    }
    return true
}