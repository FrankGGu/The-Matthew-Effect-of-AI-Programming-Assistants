import "sort"

func minimumOperations(nums []int) int {
	n := len(nums)
	if n == 1 {
		return 0
	}

	even := make(map[int]int)
	odd := make(map[int]int)

	for i := 0; i < n; i++ {
		if i%2 == 0 {
			even[nums[i]]++
		} else {
			odd[nums[i]]++
		}
	}

	evenCounts := make([]int, 0)
	for _, count := range even {
		evenCounts = append(evenCounts, count)
	}
	sort.Sort(sort.Reverse(sort.IntSlice(evenCounts)))

	oddCounts := make([]int, 0)
	for _, count := range odd {
		oddCounts = append(oddCounts, count)
	}
	sort.Sort(sort.Reverse(sort.IntSlice(oddCounts)))

	maxEven := 0
	maxOdd := 0

	var maxEvenVal int
	for k, v := range even {
		if v == evenCounts[0] {
			maxEvenVal = k
			maxEven = v
			break
		}
	}

	var maxOddVal int
	for k, v := range odd {
		if v == oddCounts[0] {
			maxOddVal = k
			maxOdd = v
			break
		}
	}

	if maxEvenVal != maxOddVal {
		return n - maxEven - maxOdd
	}

	if len(evenCounts) == 1 && len(oddCounts) == 1 {
		return n / 2
	}

	evenSecond := 0
	if len(evenCounts) > 1 {
		evenSecond = evenCounts[1]
	}

	oddSecond := 0
	if len(oddCounts) > 1 {
		oddSecond = oddCounts[1]
	}

	return n - max(maxEven+oddSecond, evenSecond+maxOdd)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func main() {}