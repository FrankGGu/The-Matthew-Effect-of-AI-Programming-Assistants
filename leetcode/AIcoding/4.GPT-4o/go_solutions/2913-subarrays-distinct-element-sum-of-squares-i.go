func distinctElementSumOfSquares(nums []int) int {
    elementCount := make(map[int]int)
    totalSum := 0

    for _, num := range nums {
        elementCount[num]++
    }

    for num := range elementCount {
        totalSum += num * num
    }

    return totalSum
}