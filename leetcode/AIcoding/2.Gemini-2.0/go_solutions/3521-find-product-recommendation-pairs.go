import "sort"

type Pair struct {
	Product1 int
	Product2 int
}

func FindProductPairs(purchases [][]int) []Pair {
	productMap := make(map[int]map[int]bool)
	for _, purchase := range purchases {
		for i := 0; i < len(purchase); i++ {
			if productMap[purchase[i]] == nil {
				productMap[purchase[i]] = make(map[int]bool)
			}
			for j := i + 1; j < len(purchase); j++ {
				productMap[purchase[i]][purchase[j]] = true
				if productMap[purchase[j]] == nil {
					productMap[purchase[j]] = make(map[int]bool)
				}
				productMap[purchase[j]][purchase[i]] = true
			}
		}
	}

	var pairs []Pair
	for product1, relatedProducts := range productMap {
		for product2 := range relatedProducts {
			if product1 < product2 {
				pairs = append(pairs, Pair{Product1: product1, Product2: product2})
			}
		}
	}

	sort.Slice(pairs, func(i, j int) bool {
		if pairs[i].Product1 != pairs[j].Product1 {
			return pairs[i].Product1 < pairs[j].Product1
		}
		return pairs[i].Product2 < pairs[j].Product2
	})

	return pairs
}