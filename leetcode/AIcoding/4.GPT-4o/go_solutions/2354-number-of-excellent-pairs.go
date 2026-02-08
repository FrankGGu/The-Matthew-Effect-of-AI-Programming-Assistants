func countExcellentPairs(nums []int, k int) int64 {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    uniqueNums := make([]int, 0)
    for num := range count {
        uniqueNums = append(uniqueNums, num)
    }

    prefixSum := make([]int, 33)
    for _, num := range uniqueNums {
        bits := 0
        for num > 0 {
            bits += num & 1
            num >>= 1
        }
        prefixSum[bits]++
    }

    result := int64(0)
    for i := 0; i < len(prefixSum); i++ {
        for j := 0; j < len(prefixSum); j++ {
            if i+j >= k {
                result += int64(prefixSum[i] * prefixSum[j])
            }
        }
    }

    return result
}