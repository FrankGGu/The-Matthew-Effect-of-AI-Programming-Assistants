import "sort"

func topKFrequent(nums []int, k int) []int {
    freqMap := make(map[int]int)
    for _, num := range nums {
        freqMap[num]++
    }

    type freqPair struct {
        num   int
        count int
    }

    freqPairs := make([]freqPair, 0, len(freqMap))
    for num, count := range freqMap {
        freqPairs = append(freqPairs, freqPair{num, count})
    }

    sort.Slice(freqPairs, func(i, j int) bool {
        return freqPairs[i].count > freqPairs[j].count
    })

    result := make([]int, 0, k)
    for i := 0; i < k; i++ {
        result = append(result, freqPairs[i].num)
    }

    return result
}