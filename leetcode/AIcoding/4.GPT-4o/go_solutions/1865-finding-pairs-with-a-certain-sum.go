func findPairs(nums []int, k int) int {
    if k < 0 {
        return 0
    }
    count := 0
    numMap := make(map[int]int)

    for _, num := range nums {
        numMap[num]++
    }

    if k == 0 {
        for _, v := range numMap {
            if v > 1 {
                count++
            }
        }
    } else {
        for num := range numMap {
            if _, exists := numMap[num+k]; exists {
                count++
            }
        }
    }

    return count
}