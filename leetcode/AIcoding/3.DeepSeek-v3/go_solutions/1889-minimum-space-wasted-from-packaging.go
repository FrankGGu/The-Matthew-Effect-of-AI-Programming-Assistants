import (
	"sort"
)

const MOD = 1e9 + 7

func minWastedSpace(packages []int, boxes [][]int) int {
	sort.Ints(packages)
	n := len(packages)
	prefix := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefix[i+1] = prefix[i] + packages[i]
	}

	minWaste := -1

	for _, boxList := range boxes {
		sort.Ints(boxList)
		if boxList[len(boxList)-1] < packages[n-1] {
			continue
		}

		currentWaste := 0
		prev := 0
		for _, box := range boxList {
			idx := sort.SearchInts(packages, box+1)
			if idx <= prev {
				continue
			}
			sum := prefix[idx] - prefix[prev]
			currentWaste += box*(idx-prev) - sum
			prev = idx
			if prev == n {
				break
			}
		}

		if prev == n {
			if minWaste == -1 || currentWaste < minWaste {
				minWaste = currentWaste
			}
		}
	}

	if minWaste == -1 {
		return -1
	}
	return minWaste % MOD
}