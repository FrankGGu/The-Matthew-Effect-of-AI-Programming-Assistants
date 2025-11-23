func kLengthApart(nums []int, k int) bool {
    lastOneIndex := -k - 1 

    for i, num := range nums {
        if num == 1 {
            if i - lastOneIndex <= k {
                return false
            }
            lastOneIndex = i
        }
    }

    return true
}