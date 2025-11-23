func minOperations(nums []int) int {
    ops := 0
    maxBinaryLen := 0
    for _, num := range nums {
        binaryLen := 0
        for num > 0 {
            if num & 1 == 1 {
                ops++
            }
            num >>= 1
            binaryLen++
        }
        if binaryLen > maxBinaryLen {
            maxBinaryLen = binaryLen
        }
    }
    if maxBinaryLen > 0 {
        ops += maxBinaryLen - 1
    }
    return ops
}