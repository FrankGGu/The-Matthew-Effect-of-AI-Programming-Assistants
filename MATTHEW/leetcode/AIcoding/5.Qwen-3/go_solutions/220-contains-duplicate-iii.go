package main

func containsNearbyAlmostDuplicate(nums []int, k int, t int) bool {
    if t < 0 || k < 0 {
        return false
    }
    bucketSize := t + 1
    buckets := make(map[int]int)
    for i, num := range nums {
        bucketId := num / bucketSize
        if num < 0 {
            bucketId--
        }
        if _, ok := buckets[bucketId]; ok {
            return true
        }
        if _, ok := buckets[bucketId-1]; ok && abs(nums[i]-nums[buckets[bucketId-1]]) <= t {
            return true
        }
        if _, ok := buckets[bucketId+1]; ok && abs(nums[i]-nums[buckets[bucketId+1]]) <= t {
            return true
        }
        buckets[bucketId] = i
        if i >= k {
            delete(buckets, nums[i-k]/bucketSize)
            if nums[i-k] < 0 {
                delete(buckets, nums[i-k]/bucketSize-1)
            } else {
                delete(buckets, nums[i-k]/bucketSize)
            }
        }
    }
    return false
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}