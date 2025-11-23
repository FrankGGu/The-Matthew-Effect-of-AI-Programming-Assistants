func sumIndicesWithKSetBits(arr []int, K int) int {
    var result int
    for i, num := range arr {
        if countSetBits(i) == K {
            result += num
        }
    }
    return result
}

func countSetBits(n int) int {
    count := 0
    for n > 0 {
        count += n & 1
        n >>= 1
    }
    return count
}