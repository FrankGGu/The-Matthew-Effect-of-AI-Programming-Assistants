func maximumGap(nums []int) int {
    if len(nums) < 2 {
        return 0
    }

    minVal, maxVal := nums[0], nums[0]
    for _, num := range nums {
        if num < minVal {
            minVal = num
        }
        if num > maxVal {
            maxVal = num
        }
    }

    bucketSize := max(1, (maxVal - minVal) / (len(nums) - 1))
    bucketCount := (maxVal - minVal) / bucketSize + 1
    buckets := make([][]int, bucketCount)

    for _, num := range nums {
        idx := (num - minVal) / bucketSize
        if buckets[idx] == nil {
            buckets[idx] = []int{num, num}
        } else {
            if num < buckets[idx][0] {
                buckets[idx][0] = num
            }
            if num > buckets[idx][1] {
                buckets[idx][1] = num
            }
        }
    }

    maxGap := 0
    prev := buckets[0][1]
    for i := 1; i < bucketCount; i++ {
        if buckets[i] == nil {
            continue
        }
        gap := buckets[i][0] - prev
        if gap > maxGap {
            maxGap = gap
        }
        prev = buckets[i][1]
    }

    return maxGap
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}