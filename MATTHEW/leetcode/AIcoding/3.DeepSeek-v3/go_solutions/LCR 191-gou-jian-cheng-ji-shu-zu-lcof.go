func statisticsMode(nums []int) []int {
    freq := make(map[int]int)
    maxFreq := 0
    for _, num := range nums {
        freq[num]++
        if freq[num] > maxFreq {
            maxFreq = freq[num]
        }
    }
    var res []int
    for num, cnt := range freq {
        if cnt == maxFreq {
            res = append(res, num)
        }
    }
    sort.Ints(res)
    return res
}