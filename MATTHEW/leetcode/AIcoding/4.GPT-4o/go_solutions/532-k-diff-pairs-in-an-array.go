func findPairs(nums []int, k int) int {
    if k < 0 {
        return 0
    }

    count := 0
    numMap := make(map[int]int)

    for _, num := range nums {
        numMap[num]++
    }

    for num, freq := range numMap {
        if k == 0 {
            if freq > 1 {
                count++
            }
        } else {
            if _, exists := numMap[num+k]; exists {
                count++
            }
        }
    }

    return count
}