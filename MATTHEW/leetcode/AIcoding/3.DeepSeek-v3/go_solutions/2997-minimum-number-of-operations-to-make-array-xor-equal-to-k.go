func minOperations(nums []int, k int) int {
    xor := 0
    for _, num := range nums {
        xor ^= num
    }
    diff := xor ^ k
    count := 0
    for diff > 0 {
        count += diff & 1
        diff >>= 1
    }
    return count
}