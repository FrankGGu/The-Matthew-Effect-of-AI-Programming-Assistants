type Solution struct {
	prefixSums []int
	rnd        *rand.Rand
}

func Constructor(w []int) Solution {
	prefixSums := make([]int, len(w))
	currentSum := 0
	for i, weight := range w {
		currentSum += weight
		prefixSums[i] = currentSum
	}

	r := rand.New(rand.NewSource(time.Now().UnixNano()))

	return Solution{
		prefixSums: prefixSums,
		rnd:        r,
	}
}

func (this *Solution) PickIndex() int {
	totalSum := this.prefixSums[len(this.prefixSums)-1]
	target := this.rnd.Intn(totalSum) + 1

	idx := sort.SearchInts(this.prefixSums, target)

	return idx
}