func minKBitFlips(nums []int, k int) int {
    n := len(nums)
    flip := make([]int, n+1)
    res := 0
    currentFlip := 0

    for i := 0; i < n; i++ {
        currentFlip ^= flip[i]
        if nums[i] == currentFlip {
            if i + k > n {
                return -1
            }
            res++
            currentFlip ^= 1
            flip[i] ^= 1
            flip[i + k] ^= 1
        }
    }
    return res
}