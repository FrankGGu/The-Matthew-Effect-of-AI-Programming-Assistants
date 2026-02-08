func containsNearbyAlmostDuplicate(nums []int, k int, t int) bool {
	if k < 1 || t < 0 {
		return false
	}
	buckets := make(map[int]int)
	for i, num := range nums {
		bucketID := num / (t + 1)
		if t == 0 {
			bucketID = num
		}

		if _, ok := buckets[bucketID]; ok {
			return true
		}
		if val, ok := buckets[bucketID-1]; ok && num-val <= t {
			return true
		}
		if val, ok := buckets[bucketID+1]; ok && val-num <= t {
			return true
		}

		buckets[bucketID] = num

		if i >= k {
			oldBucketID := nums[i-k] / (t + 1)
			if t == 0 {
				oldBucketID = nums[i-k]
			}
			delete(buckets, oldBucketID)
		}
	}
	return false
}