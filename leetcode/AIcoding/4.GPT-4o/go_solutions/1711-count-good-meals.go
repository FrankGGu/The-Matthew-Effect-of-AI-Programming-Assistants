func countGoodMeals(deliciousness []int) int {
    const mod = 1_000_000_007
    count := make(map[int]int)
    result := 0

    for _, d := range deliciousness {
        for p := 1; p <= 1<<21; p <<= 1 {
            if c, exists := count[p-d]; exists {
                result = (result + c) % mod
            }
        }
        count[d]++
    }

    return result
}