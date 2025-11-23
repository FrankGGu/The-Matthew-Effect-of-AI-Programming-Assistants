func beautifulSplits(nums []int) int {
    count := 0
    prefixSum := make([]int, len(nums)+1)
    for i, num := range nums {
        prefixSum[i+1] = prefixSum[i] + num
    }
    totalSum := prefixSum[len(nums)]

    for i := 1; i < len(nums); i++ {
        if prefixSum[i] == totalSum-prefixSum[i] {
            count++
        }
    }
    return count
}