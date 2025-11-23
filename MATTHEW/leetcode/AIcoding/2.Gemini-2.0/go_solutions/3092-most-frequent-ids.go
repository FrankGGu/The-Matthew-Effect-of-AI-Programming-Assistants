func mostFrequentIDs(ids []int) []int {
    freqMap := make(map[int]int)
    maxFreq := 0
    for _, id := range ids {
        freqMap[id]++
        if freqMap[id] > maxFreq {
            maxFreq = freqMap[id]
        }
    }

    var result []int
    for id, freq := range freqMap {
        if freq == maxFreq {
            result = append(result, id)
        }
    }

    return result
}