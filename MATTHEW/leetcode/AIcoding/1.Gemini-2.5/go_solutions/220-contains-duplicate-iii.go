func containsNearbyAlmostDuplicate(nums []int, k int, t int) bool {
    if t < 0 {
        return false
    }
    buckets := make(map[int]int)
    w := t + 1
    for i := range nums {
        id := getID(nums[i], w)
        if _, ok := buckets[id]; ok {
            return true
        }
        if v, ok := buckets[id-1]; ok && abs(nums[i]-v) <= t {
            return true
        }
        if v, ok := buckets[id+1]; ok && abs(nums[i]-v) <= t {
            return true
        }
        buckets[id] = nums[i]
        if i >= k {
            delete(buckets, getID(nums[i-k], w))
        }
    }
    return false
}

func getID(x, w int) int {
    if x >= 0 {
        return x / w
    }
    return (x+1)/w - 1
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}