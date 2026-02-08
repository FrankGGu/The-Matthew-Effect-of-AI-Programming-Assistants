func countPairs(nums []int, k int) int64 {
    count := make([]int, k)
    for _, num := range nums {
        count[(num % k + k) % k]++
    }

    result := int64(0)
    for i := 0; i < k; i++ {
        for j := i; j < k; j++ {
            if (i + j) % k == 0 {
                if i == j {
                    result += int64(count[i] * (count[i] - 1) / 2)
                } else {
                    result += int64(count[i] * count[j])
                }
            }
        }
    }

    return result
}