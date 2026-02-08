func topKFrequent(nums []int, k int) []int {
    freqMap := make(map[int]int)
    for _, num := range nums {
        freqMap[num]++
    }

    buckets := make([][]int, len(nums)+1)
    for num, freq := range freqMap {
        buckets[freq] = append(buckets[freq], num)
    }

    res := make([]int, 0, k)
    for i := len(buckets)-1; i >= 0 && len(res) < k; i-- {
        if len(buckets[i]) > 0 {
            res = append(res, buckets[i]...)
        }
    }

    return res[:k]
}