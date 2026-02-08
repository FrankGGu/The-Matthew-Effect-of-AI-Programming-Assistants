func containsNearbyAlmostDuplicate(nums []int, indexDiff int, valueDiff int) bool {
    if indexDiff <= 0 || valueDiff < 0 {
        return false
    }

    bucket := make(map[int]int)
    w := valueDiff + 1

    for i, num := range nums {
        bucketIndex := num / w

        if _, exists := bucket[bucketIndex]; exists {
            return true
        }

        if val, exists := bucket[bucketIndex-1]; exists && abs(val-num) <= valueDiff {
            return true
        }

        if val, exists := bucket[bucketIndex+1]; exists && abs(val-num) <= valueDiff {
            return true
        }

        bucket[bucketIndex] = num

        if i >= indexDiff {
            delete(bucket, nums[i-indexDiff]/w)
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