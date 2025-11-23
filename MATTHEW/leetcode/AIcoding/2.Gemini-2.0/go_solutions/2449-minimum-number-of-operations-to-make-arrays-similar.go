import (
	"sort"
)

func makeSimilar(nums []int, target []int) int64 {
	oddNums := []int{}
	evenNums := []int{}
	oddTarget := []int{}
	evenTarget := []int{}

	for _, num := range nums {
		if num%2 == 0 {
			evenNums = append(evenNums, num)
		} else {
			oddNums = append(oddNums, num)
		}
	}

	for _, num := range target {
		if num%2 == 0 {
			evenTarget = append(evenTarget, num)
		} else {
			oddTarget = append(oddTarget, num)
		}
	}

	sort.Ints(oddNums)
	sort.Ints(evenNums)
	sort.Ints(oddTarget)
	sort.Ints(evenTarget)

	var ops int64
	for i := 0; i < len(oddNums); i++ {
		if oddNums[i] > oddTarget[i] {
			ops += int64(oddNums[i]-oddTarget[i]) / 2
		}
	}

	for i := 0; i < len(evenNums); i++ {
		if evenNums[i] > evenTarget[i] {
			ops += int64(evenNums[i]-evenTarget[i]) / 2
		}
	}

	return ops
}