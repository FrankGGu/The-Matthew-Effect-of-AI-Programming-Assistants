func numberOfGoodPartitions(nums []int) int {
    lastOccurrence := make(map[int]int)
    for i, num := range nums {
        lastOccurrence[num] = i
    }

    res := 1
    maxPos := 0
    for i := 0; i < len(nums); i++ {
        if lastOccurrence[nums[i]] > maxPos {
            maxPos = lastOccurrence[nums[i]]
        }
        if i == maxPos {
            res = (res * 2) % 1000000007
        }
    }
    return res / 2
}