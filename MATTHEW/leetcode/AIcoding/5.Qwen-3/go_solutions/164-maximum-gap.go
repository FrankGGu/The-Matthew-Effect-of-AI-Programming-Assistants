package main

func maximumGap(nums []int) int {
	if len(nums) < 2 {
		return 0
	}

	maxNum := nums[0]
	minNum := nums[0]
	for _, num := range nums {
		if num > maxNum {
			maxNum = num
		}
		if num < minNum {
			minNum = num
		}
	}

	n := len(nums)
	if maxNum == minNum {
		return 0
	}

	bucketSize := (maxNum - minNum) / (n - 1)
	if bucketSize == 0 {
		bucketSize = 1
	}

	buckets := make([][2]int, n)
	for i := range buckets {
		buckets[i] = [2]int{-1, -1}
	}

	for _, num := range nums {
		idx := (num - minNum) / bucketSize
		if buckets[idx][0] == -1 {
			buckets[idx][0] = num
			buckets[idx][1] = num
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
	prev := minNum
	for _, bucket := range buckets {
		if bucket[0] == -1 {
			continue
		}
		maxGap = max(maxGap, bucket[0]-prev)
		prev = bucket[1]
	}

	return maxGap
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}