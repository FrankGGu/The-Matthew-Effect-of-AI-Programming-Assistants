func findDistinctDifferenceArray(nums []int) []int {
    n := len(nums)
    answer := make([]int, n)
    leftCount := make(map[int]int)
    rightCount := make(map[int]int)

    for _, num := range nums {
        rightCount[num]++
    }

    for i, num := range nums {
        rightCount[num]--
        if rightCount[num] == 0 {
            delete(rightCount, num)
        }
        leftCount[num]++

        answer[i] = len(leftCount) - len(rightCount)
    }

    return answer
}