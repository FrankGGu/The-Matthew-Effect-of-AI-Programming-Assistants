import (
	"sort"
)

func minGroupsForValidAssignment(nums []int) int {
	counts := make(map[int]int)
	for _, num := range nums {
		counts[num]++
	}

	freqs := []int{}
	for _, count := range counts {
		freqs = append(freqs, count)
	}

	sort.Ints(freqs)

	n := len(freqs)
	ans := freqs[0]
	for x := freqs[0]; x >= 1; x-- {
		groups := 0
		possible := true
		for i := 0; i < n; i++ {
			if freqs[i] < x {
				possible = false
				break
			}

			k := freqs[i] / (x + 1)
			rem := freqs[i] % (x + 1)
			if rem > k {
				groups += k + 1
			} else {
				groups += k
			}
		}
		if possible {
			ans = groups
			break
		}
	}

	return ans
}