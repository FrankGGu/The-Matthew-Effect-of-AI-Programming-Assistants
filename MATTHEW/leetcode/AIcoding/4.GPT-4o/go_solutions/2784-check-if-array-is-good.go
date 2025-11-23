func isGood(nums []int) bool {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    for i := 1; i <= len(nums); i++ {
        if count[i] != i {
            return false
        }
    }

    return true
}