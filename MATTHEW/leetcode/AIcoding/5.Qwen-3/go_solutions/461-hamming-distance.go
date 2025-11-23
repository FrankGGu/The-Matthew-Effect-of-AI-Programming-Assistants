package leetcode

func hammingDistance(x int, y int) int {
    xor := x ^ y
    count := 0
    for xor != 0 {
        count += xor & 1
        xor >>= 1
    }
    return count
}