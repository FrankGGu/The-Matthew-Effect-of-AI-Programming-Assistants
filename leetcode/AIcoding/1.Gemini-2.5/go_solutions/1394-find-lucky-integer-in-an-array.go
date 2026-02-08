func findLucky(arr []int) int {
    freqMap := make(map[int]int)
    for _, num := range arr {
        freqMap[num]++
    }

    maxLucky := -1
    for num, freq := range freqMap {
        if num == freq {
            if num > maxLucky {
                maxLucky = num
            }
        }
    }

    return maxLucky
}