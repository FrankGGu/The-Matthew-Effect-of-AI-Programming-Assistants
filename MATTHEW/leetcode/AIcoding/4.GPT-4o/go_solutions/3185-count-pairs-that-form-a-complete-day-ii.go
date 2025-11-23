func countPairs(deliciousness []int) int {
    const mod = 1_000_000_007
    count := make(map[int]int)
    result := 0

    for _, num := range deliciousness {
        for i := 0; i <= 21; i++ {
            target := 1 << i
            if val, exists := count[target-num]; exists {
                result = (result + val) % mod
            }
        }
        count[num]++
    }

    return result
}