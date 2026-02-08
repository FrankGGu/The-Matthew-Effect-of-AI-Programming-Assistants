func containsNearbyAlmostDuplicate(nums []int, k int, t int) bool {
    if t < 0 {
        return false
    }
    buckets := make(map[int]int)
    w := t + 1
    for i, num := range nums {
        bucket := getBucket(num, w)
        if _, ok := buckets[bucket]; ok {
            return true
        }
        if v, ok := buckets[bucket-1]; ok && abs(num-v) <= t {
            return true
        }
        if v, ok := buckets[bucket+1]; ok && abs(num-v) <= t {
            return true
        }
        buckets[bucket] = num
        if i >= k {
            delete(buckets, getBucket(nums[i-k], w))
        }
    }
    return false
}

func getBucket(num, w int) int {
    if num >= 0 {
        return num / w
    }
    return (num+1)/w - 1
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}