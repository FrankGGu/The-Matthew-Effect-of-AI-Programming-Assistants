func findErrorNums(nums []int) []int {
    n := len(nums)
    numMap := make(map[int]int)
    duplicate := 0
    sum := 0
    for _, num := range nums {
        numMap[num]++
        if numMap[num] > 1 {
            duplicate = num
        }
        sum += num
    }

    expectedSum := n * (n + 1) / 2
    missing := expectedSum - (sum - duplicate)

    return []int{duplicate, missing}
}