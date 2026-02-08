func countExcellentPairs(nums []int, k int) int64 {
    seen := make(map[int]bool)
    count := make([]int, 32)
    for _, num := range nums {
        if !seen[num] {
            seen[num] = true
            bits := bits.OnesCount(uint(num))
            count[bits]++
        }
    }
    var res int64
    for i := 0; i < 32; i++ {
        for j := 0; j < 32; j++ {
            if i + j >= k {
                res += int64(count[i] * count[j])
            }
        }
    }
    return res
}