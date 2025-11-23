func isGood(nums []int) bool {
    n := len(nums)
    if n == 0 {
        return false
    }
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }
    if maxNum != n-1 {
        return false
    }
    freq := make([]int, maxNum+1)
    for _, num := range nums {
        if num < 1 || num > maxNum {
            return false
        }
        freq[num]++
    }
    for i := 1; i < maxNum; i++ {
        if freq[i] != 1 {
            return false
        }
    }
    if freq[maxNum] != 2 {
        return false
    }
    return true
}