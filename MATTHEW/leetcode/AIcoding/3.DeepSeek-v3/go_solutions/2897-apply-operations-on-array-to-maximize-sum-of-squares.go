func maxSum(nums []int, k int) int {
    const mod = 1e9 + 7
    bits := make([]int, 31)
    for _, num := range nums {
        for i := 0; i < 31; i++ {
            if num&(1<<i) != 0 {
                bits[i]++
            }
        }
    }

    res := 0
    for i := 0; i < k; i++ {
        x := 0
        for j := 0; j < 31; j++ {
            if bits[j] > 0 {
                x |= 1 << j
                bits[j]--
            }
        }
        res = (res + x * x) % mod
    }
    return res
}