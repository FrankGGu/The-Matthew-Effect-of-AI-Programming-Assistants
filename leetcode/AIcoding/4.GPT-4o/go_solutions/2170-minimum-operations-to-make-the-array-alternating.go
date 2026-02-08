func minimumOperations(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    type pair struct {
        num  int
        freq int
    }

    var freqList []pair
    for num, freq := range count {
        freqList = append(freqList, pair{num, freq})
    }

    sort.Slice(freqList, func(i, j int) bool {
        return freqList[i].freq > freqList[j].freq
    })

    mostFreq, secondFreq := 0, 0
    if len(freqList) > 0 {
        mostFreq = freqList[0].freq
    }
    if len(freqList) > 1 {
        secondFreq = freqList[1].freq
    }

    return len(nums) - mostFreq - max(0, (len(nums)-mostFreq-secondFreq))
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}