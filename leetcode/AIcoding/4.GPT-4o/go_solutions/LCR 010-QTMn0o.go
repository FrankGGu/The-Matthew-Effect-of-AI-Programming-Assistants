func subarraySum(nums []int, k int) int {
    count := 0
    sumMap := make(map[int]int)
    sumMap[0] = 1
    currentSum := 0

    for _, num := range nums {
        currentSum += num
        if val, ok := sumMap[currentSum-k]; ok {
            count += val
        }
        sumMap[currentSum]++
    }

    return count
}