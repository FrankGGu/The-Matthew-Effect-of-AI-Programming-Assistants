func containsNearbyAlmostDuplicate(nums []int, k int, t int) bool {
    if k <= 0 || t < 0 {
        return false
    }
    bucket := make(map[int64]int)
    width := int64(t) + 1

    for i, num := range nums {
        bucketID := int64(num) / width
        if _, ok := bucket[bucketID]; ok {
            return true
        }
        if val, ok := bucket[bucketID-1]; ok && int64(num)-int64(val) <= int64(t) {
            return true
        }
        if val, ok := bucket[bucketID+1]; ok && int64(val)-int64(num) <= int64(t) {
            return true
        }

        bucket[bucketID] = int64(num)
        if i >= k {
            delete(bucket, int64(nums[i-k])/width)
        }
    }
    return false
}