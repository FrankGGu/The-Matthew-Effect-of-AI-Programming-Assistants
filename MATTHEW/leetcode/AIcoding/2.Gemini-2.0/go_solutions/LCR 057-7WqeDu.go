func containsNearbyAlmostDuplicate(nums []int, k int, t int) bool {
    if k < 1 || t < 0 {
        return false
    }
    m := make(map[int]int)
    for i, v := range nums {
        bucket := v / (t + 1)
        if v < 0 {
            bucket--
        }
        if _, ok := m[bucket]; ok {
            return true
        }
        if val, ok := m[bucket-1]; ok && abs(v-val) <= t {
            return true
        }
        if val, ok := m[bucket+1]; ok && abs(v-val) <= t {
            return true
        }
        m[bucket] = v
        if i >= k {
            oldBucket := nums[i-k] / (t + 1)
            if nums[i-k] < 0 {
                oldBucket--
            }
            delete(m, oldBucket)
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