func getBucketID(x, w int64) int64 {
	if x >= 0 {
		return x / w
	}
	// For negative numbers, Go's division truncates towards zero.
	// We need floor division.
	// Example: x = -5, w = 3. x/w = -1. floor(-5/3) = -2.
	// (x - w + 1) / w: (-5 - 3 + 1) / 3 = -7 / 3 = -2.
	return (x - w + 1) / w
}

func containsNearbyAlmostDuplicate(nums []int, k int, t int) bool {
	if t < 0 || k < 0 {
		return false
	}

	// Use int64 for bucketSize and values to prevent overflow,
	// especially when t is large (2^31 - 1) and nums[i] is negative.
	// bucketSize = t + 1. If t = 2^31 - 1, then t+1 = 2^31.
	// This value needs to be int64 to avoid overflow if int is int32.
	bucketSize := int64(t) + 1

	buckets := make(map[int64]int64) // map bucketID to the number in that bucket

	for i, num := range nums {
		val := int64(num)

		bucketID := getBucketID(val, bucketSize)

		// Check current bucket
		if _, ok := buckets[bucketID]; ok {
			return true
		}

		// Check adjacent buckets
		// bucketID - 1
		if prevVal, ok := buckets[bucketID-1]; ok {
			// abs(val - prevVal) <= t
			// Since prevVal is in a lower bucket, prevVal < val is expected.
			// So, val - prevVal >= 0. We just need to check val - prevVal <= t.
			if val-prevVal <= int64(t) {
				return true
			}
		}
		// bucketID + 1
		if nextVal, ok := buckets[bucketID+1]; ok {
			// abs(val - nextVal) <= t
			// Since nextVal is in a higher bucket, nextVal > val is expected.
			// So, nextVal - val >= 0. We just need to check nextVal - val <= t.
			if nextVal-val <= int64(t) {
				return true
			}
		}

		// Add current number to its bucket
		buckets[bucketID] = val

		// Remove the number that falls out of the window
		// The window for nums[i] is [nums[i-k], ..., nums[i-1]].
		// So, when we process nums[i], if i >= k, then nums[i-k] is no longer in the window.
		if i >= k {
			oldVal := int64(nums[i-k])
			oldBucketID := getBucketID(oldVal, bucketSize)
			delete(buckets, oldBucketID)
		}
	}

	return false
}