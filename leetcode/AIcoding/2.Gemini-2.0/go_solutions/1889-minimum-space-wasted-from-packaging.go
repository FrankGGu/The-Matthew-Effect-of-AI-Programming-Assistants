import (
	"sort"
)

func minSpaceWastedK(packages []int, boxes [][]int) int {
	MOD := 1000000007
	n := len(packages)
	sort.Ints(packages)

	minWaste := int64(-1)

	for _, boxTypes := range boxes {
		sort.Ints(boxTypes)
		if boxTypes[len(boxTypes)-1] < packages[n-1] {
			continue
		}

		waste := int64(0)
		valid := true
		for _, pack := range packages {
			idx := sort.SearchInts(boxTypes, pack)
			if idx == len(boxTypes) {
				valid = false
				break
			}
			waste += int64(boxTypes[idx] - pack)
		}

		if valid {
			if minWaste == -1 || waste < minWaste {
				minWaste = waste
			}
		}
	}

	if minWaste == -1 {
		return -1
	}

	return int(minWaste % int64(MOD))
}