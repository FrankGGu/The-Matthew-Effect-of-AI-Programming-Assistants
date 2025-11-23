func findLeastNumOfUniqueInts(arr []int, k int) int {
    frequency := make(map[int]int)
    for _, num := range arr {
        frequency[num]++
    }

    uniqueCount := len(frequency)
    freqList := make([]int, 0, uniqueCount)
    for _, count := range frequency {
        freqList = append(freqList, count)
    }

    sort.Ints(freqList)

    for _, count := range freqList {
        if k >= count {
            k -= count
            uniqueCount--
        } else {
            break
        }
    }

    return uniqueCount
}