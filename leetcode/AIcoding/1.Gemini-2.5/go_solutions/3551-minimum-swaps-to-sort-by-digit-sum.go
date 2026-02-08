import (
	"sort"
)

func digitSum(n int) int {
	sum := 0
	for n > 0 {
		sum += n % 10
		n /= 10
	}
	return sum
}

type Item struct {
	val         int
	sum         int
	originalIdx int
}

func minimumSwaps(nums []int) int {
	n := len(nums)
	if n <= 1 {
		return 0
	}

	items := make([]Item, n)
	for i, num := range nums {
		items[i] = Item{val: num, sum: digitSum(num), originalIdx: i}
	}

	sort.Slice(items, func(i, j int) bool {
		if items[i].sum != items[j].sum {
			return items[i].sum < items[j].sum
		}
		return items[i].val < items[j].val
	})

	targetPos := make([]int, n)
	for i := 0; i < n; i++ {
		targetPos[items[i].originalIdx] = i
	}

	swaps := 0
	visited := make([]bool, n)

	for i := 0; i < n; i++ {
		if visited[i] || targetPos[i] == i {
			continue
		}

		cycleSize := 0
		j := i
		for !visited[j] {
			visited[j] = true
			j = targetPos[j]
			cycleSize++
		}
		swaps += cycleSize - 1
	}

	return swaps
}