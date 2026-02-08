package main

func maximumTastiness(candies []int, numPeople int) int {
	sort.Ints(candies)
	left, right := 0, candies[len(candies)-1]-candies[0]
	result := 0

	for left <= right {
		mid := (left + right) / 2
		count := 1
		prev := candies[0]

		for i := 1; i < len(candies); i++ {
			if candies[i]-prev >= mid {
				count++
				prev = candies[i]
			}
		}

		if count >= numPeople {
			result = mid
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	return result
}