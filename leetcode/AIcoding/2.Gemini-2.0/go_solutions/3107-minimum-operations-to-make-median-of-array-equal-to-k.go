import (
	"sort"
)

func minOperations(nums []int, k int) int {
	n := len(nums)
	less := 0
	greater := 0
	equal := 0
	for _, num := range nums {
		if num < k {
			less++
		} else if num > k {
			greater++
		} else {
			equal++
		}
	}

	if n%2 == 0 {
		target := n/2
		if less >= target {
			return 0
		}

		return target - less
	} else {
		target := (n+1)/2
		if less >= target {
			return 0
		}

		return target - less
	}
}

func main() {}