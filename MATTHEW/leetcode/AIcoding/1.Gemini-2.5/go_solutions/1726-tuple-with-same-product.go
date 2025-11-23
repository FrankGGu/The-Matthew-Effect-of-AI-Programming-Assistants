func tupleSameProduct(nums []int) int {
    productCount := make(map[int]int)
    n := len(nums)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            product := nums[i] * nums[j]
            productCount[product]++
        }
    }
    res := 0
    for _, count := range productCount {
        if count >= 2 {
            res += count * (count - 1) / 2 * 8
        }
    }
    return res
}