func maxNonOverlapping(nums []int, target int) int {
    sumMap := make(map[int]int)
    sumMap[0] = 1
    sum := 0
    count := 0
    prevCount := 0

    for _, num := range nums {
        sum += num
        if _, exists := sumMap[sum-target]; exists {
            count++
            prevCount = sumMap[sum-target]
            sumMap = make(map[int]int)
            sumMap[0] = 1
            sum = 0
        }
        sumMap[sum]++
    }

    return count
}