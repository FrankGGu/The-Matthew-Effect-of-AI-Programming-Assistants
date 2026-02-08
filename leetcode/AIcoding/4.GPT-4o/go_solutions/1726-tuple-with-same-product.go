func tupleSameProduct(nums []int) int {
    count := make(map[int]int)
    result := 0

    for i := 0; i < len(nums); i++ {
        for j := i + 1; j < len(nums); j++ {
            product := nums[i] * nums[j]
            count[product]++
        }
    }

    for _, v := range count {
        result += v * (v - 1)
    }

    return result
}