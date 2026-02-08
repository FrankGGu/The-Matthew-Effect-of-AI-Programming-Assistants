import (
	"sort"
)

func findMedian(nums []int) float64 {
	m := make(map[int]bool)
	uniqueNums := []int{}
	for _, num := range nums {
		if !m[num] {
			m[num] = true
			uniqueNums = append(uniqueNums, num)
		}
	}
	sort.Ints(uniqueNums)
	n := len(uniqueNums)
	if n%2 == 0 {
		return float64(uniqueNums[n/2-1]+uniqueNums[n/2]) / 2.0
	} else {
		return float64(uniqueNums[n/2])
	}
}