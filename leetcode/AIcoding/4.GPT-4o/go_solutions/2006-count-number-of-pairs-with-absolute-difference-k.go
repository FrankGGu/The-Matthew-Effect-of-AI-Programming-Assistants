func countKDifference(nums []int, k int) int {
    count := 0
    numMap := make(map[int]int)

    for _, num := range nums {
        count += numMap[num-k] + numMap[num+k]
        numMap[num]++
    }

    return count
}