func findLastVisited(nums []int, k int) []int {
    lastVisited := make(map[int]int)
    result := make([]int, 0)

    for i := 0; i < len(nums); i++ {
        lastVisited[nums[i]] = i
    }

    for _, num := range nums {
        if lastVisited[num] >= len(nums)-k {
            result = append(result, num)
        }
    }

    return result
}