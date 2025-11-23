func numIdenticalPairs(nums []int) int {
    count := 0
    frequency := make(map[int]int)

    for _, num := range nums {
        count += frequency[num]
        frequency[num]++
    }

    return count
}