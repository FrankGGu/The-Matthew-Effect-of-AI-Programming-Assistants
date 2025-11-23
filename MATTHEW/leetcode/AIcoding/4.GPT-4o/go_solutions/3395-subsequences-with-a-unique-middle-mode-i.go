func uniqueMiddleMode(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    uniqueModes := make([]int, 0)
    maxCount := 0

    for _, c := range count {
        if c > maxCount {
            maxCount = c
        }
    }

    for num, c := range count {
        if c == maxCount {
            uniqueModes = append(uniqueModes, num)
        }
    }

    if len(uniqueModes) == 1 {
        return uniqueModes[0]
    }
    return -1
}