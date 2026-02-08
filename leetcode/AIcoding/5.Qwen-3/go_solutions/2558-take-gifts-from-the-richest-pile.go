package main

func pickGifts(gifts []int, k int) int {
	for i := 0; i < k; i++ {
		max := 0
		index := 0
		for j := 0; j < len(gifts); j++ {
			if gifts[j] > max {
				max = gifts[j]
				index = j
			}
		}
		gifts[index] = int(math.Sqrt(float64(max)))
	}
	sum := 0
	for _, v := range gifts {
		sum += v
	}
	return sum
}