func numSubarraysWithSum(A []int, S int) int {
    count := make(map[int]int)
    count[0] = 1
    sum, result := 0, 0

    for _, num := range A {
        sum += num
        result += count[sum-S]
        count[sum]++
    }

    return result
}