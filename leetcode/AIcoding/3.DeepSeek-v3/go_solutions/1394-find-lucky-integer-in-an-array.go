func findLucky(arr []int) int {
    freq := make(map[int]int)
    for _, num := range arr {
        freq[num]++
    }
    maxLucky := -1
    for num, count := range freq {
        if num == count && num > maxLucky {
            maxLucky = num
        }
    }
    return maxLucky
}