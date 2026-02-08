import "sort"

func colorfulSet(items []int) int {
	sort.Ints(items)
	n := len(items)
	ans := 0
	for i := 0; i < (1 << n); i++ {
		subset := []int{}
		for j := 0; j < n; j++ {
			if (i>>j)&1 == 1 {
				subset = append(subset, items[j])
			}
		}

		if len(subset) == 0 {
			continue
		}

		distinct := true
		products := make(map[int]bool)
		for k := 0; k < len(subset); k++ {
			product := subset[k]
			if products[product] {
				distinct = false
				break
			}
			products[product] = true
			for l := k + 1; l < len(subset); l++ {
				product *= subset[l]
				if products[product] {
					distinct = false
					break
				}
				products[product] = true
			}
			if !distinct {
				break
			}
		}

		if distinct {
			ans++
		}
	}
	return ans
}