func countBits(n int) []int {
    ans := make([]int, n+1)
    // ans[0] is 0, which is the default value for int in a slice.

    for i := 1; i <= n; i++ {
        // The number of set bits in i is the number of set bits in i/2
        // plus 1 if i is odd (i.e., its least significant bit is 1),
        // or plus 0 if i is even (i.e., its least significant bit is 0).
        // This can be expressed using bitwise operations:
        // i >> 1 is equivalent to i / 2
        // i & 1 is 1 if i is odd, 0 if i is even
        ans[i] = ans[i>>1] + (i & 1)
    }

    return ans
}