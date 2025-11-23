import "sort"

func getPower(n int) int {
	power := 0
	for n != 1 {
		if n%2 == 0 {
			n /= 2
		} else {
			n = 3*n + 1
		}
		power++
	}
	return power
}

func getKth(lo int, hi int, k int) int {
	type Pair struct {
		Num   int
		Power int
	}

	pairs := make([]Pair, 0, hi-lo+1)
	for i := lo; i <= hi; i++ {
		pairs = append(pairs, Pair{Num: i, Power: getPower(i)})
	}

	sort.Slice(pairs, func(i, j int) bool {
		if pairs[i].Power == pairs[j].Power {
			return pairs[i].Num < pairs[j].Num
		}
		return pairs[i].Power < pairs[j].Power
	})

	return pairs[k-1].Num
}